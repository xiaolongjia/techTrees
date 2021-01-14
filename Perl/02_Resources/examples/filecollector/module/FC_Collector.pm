package FC_Collector;

###############################################################################
#
#  @(#) Perl Module: FC_Collector
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JiaXiaoLong
#  
#  Creation Date: 2002/12/12
#
#  Description:1.This package is the base of file collection.It reads the config
#		file, connects bss or msc and sends commands to collect data. 
#	       2.The second functions of this module are: common prepare method
#		 and common postprocess method. 
#
###############################################################################

use Env qw(NPM_HOME);
use XML::Simple;
use Data::Dumper;
use threads;
use threads::shared;

use StdCollect;
use StdConnect;
@ISA=("StdCollect","StdConnect");

use Exporter;
@ISA=('Exporter');
@EXPORT=qw(WriteHash2Col_cfg);

use lib "$NPM_HOME/common/modules";

use DBIs;

##############################################################
#
#  Function:new
#
#  Input:
#
#  Output:
#
#  Return value:
#
#  Description:create filecollector
#
#
#############################################################

sub new{
	my ($pkg,$Assistant_Var,$ErrMessage_hdl,$db_para) = @_;
	my $filecollector=bless{
				'Assistant_Var'=> $Assistant_Var,
				'ErrMessage_hdl'=> $ErrMessage_hdl,
				'db_para' => $db_para,
				'connect_handle'=>'NULL',
				'connect_func'=>'NULL',
				'command_func'=>'NULL'
			},$pkg;
	return $filecollector;
} 

#----------------------------------------------------------------------#
# common file collection part. 
#----------------------------------------------------------------------#

##############################################################
#
#  Function:creat_method_function
#
#  Input:
#
#  Output:
#
#  Return value:connect and command functions
#
#  Description: read method_module.xml 
#
#
#############################################################

sub creat_method_function{
	my $colcfg="$NPM_HOME/common/mbin/filecollector/config/method_func.xml";
	DBIs::Trace("Read method_func file: $colcfg\n");
	if(!(-r	 $colcfg)){
			$err_msg="Can't read file $colcfg .\n File:".__FILE__."\t Line:".__LINE__."\n";
			DBIs::Trace("$err_msg");
			return (-1,$err_msg,'','');
	}

	$act_func_map=eval{XMLin("$colcfg")};
	if($@){
		$err_msg="$@ File:".__FILE__."\t Line:".__LINE__."\n";
		return (-1,$err_msg,'','');
	}					
	return (1,'success\n',$act_func_map->{'Connect_Method'},$act_func_map->{'Command_Method'});
}

##############################################################
#
#  Function:connect_ne
#
#  Input:1.connect information which has structure:
#		{
#			connect_type,
#			other necessary information.
#		}
#	 2.connect handle
#  Output:
#
#  Return value:$return_code,$return_message,$connect_hdl.
#		$return_code=1,success, others fail.
#
#  Description:this function is designed to control all kinds of
#		connection.
#
#
#############################################################

sub connect_ne{
	my ($pkg,$connect_inf,$connect_hdl)=@_;
	my ($result_code,$result_msg);	
	my $connect_type=lc($connect_inf->{'Connect_type'});
	my $connect_func=$pkg->{'connect_func'}{$connect_type}{'Function'};
#	print "$connect_type\n";
#	print "$connect_func\n";
	#----------------------------------
	# handle NULL connection: rcp,rsh
	#----------------------------------
	if($connect_type=~/NULL/i){
		return (1,"success \n",$connect_hdl);
	}
	if(!(defined $connect_func)){
		return(-1," the type of $connect_type is not used \n",$connect_hdl);
		}
	else {
		#print Dumper $connect_hdl;
		DBIs::Trace("Connect Func:$connect_func\n");
                ($result_code,$result_msg,$connect_hdl)=$pkg->$connect_func($connect_inf,$connect_hdl);
                if($result_code==1){
                        return (1,"$connect_type success\n",$connect_hdl);
                }
                else{
                        return (-1,$result_msg);
                }
        }
}

##############################################################
#
#  Function:execute_connect
#
#  Input: the ref hash of connection information.
#
#  Output:
#
#  Return value:1 connect succes, -1 connect fail
#
#  Description:connect omc/oss/terminal and bss/msc,etc.
#
#
#############################################################

sub execute_connect{
	my ($pkg,$cnt_inf)=@_;
	my $max_retry=$cnt_inf->{'retry'}{'maxtimes'};
	if (!$max_retry){$max_retry=0;}

	#-------------------------------------------------
	# $ne1_cntinf is omc/oss connection information
	# and 
	# $ne2_cntinf is bss/msc connection information
	#-------------------------------------------------
	$cnt_inf= $pkg->Format_HashStruc($cnt_inf);
	my $ne1_cntinf= $cnt_inf->{'ne'};
	my $ne2_cntinf= $cnt_inf->{'ne'}{'child_ne'};
	delete $ne1_cntinf->{'child_ne'};

	my ($return_code,$return_msg,$err_msg,$connect_hdl);
	my $retry_times=0;

	while(($retry_times<=$max_retry)){
		$retry_times++;

		#----------------------------
		# connect omc/oss
		#----------------------------
		($return_code,$return_msg,$connect_hdl)=$pkg->connect_ne($ne1_cntinf,0);

		#---------------------------------------------------------
		# connect omc/oss error, retry here.
		#---------------------------------------------------------
		if ($return_code==-1){
			$err_msg=$return_msg."\n\tFile:".__FILE__."\n\tLine:".__LINE__."\n";
			next;
		} 

		#---------------------------------------------------------
		# connect bss/msc. if connection is error here , we
		# close the connect handle comming from connecting omc/oss
		#---------------------------------------------------------
		($return_code,$return_msg,$connect_hdl)=$pkg->connect_ne($ne2_cntinf,$connect_hdl);

		#---------------------------------------------------------
		# connect msc/bss error, retry here.
		#---------------------------------------------------------
		if ($return_code==-1){
			$err_msg=$return_msg."\n\tFile:".__FILE__."\n\tLine:".__LINE__."\n";
			next;
		}
		
		#---------------------------------------------------------
		# success. Note, for rcp&rsh,connection doesn't need.
		# $pkg->{'connect_handle'}= NULL is in this case.
		#---------------------------------------------------------
		if($connect_hdl){
			$pkg->{'connect_handle'}=$connect_hdl;
		}
		
		return (1,"Connect successfully\n");
	}
	
	#--------------------------------
	# fail,need trace here.
	#--------------------------------
	
	return (-1,$err_msg);
}

##############################################################
#
#  Function:execute_cmdlist
#
#  Input: command information
#
#  Output: data file collected
#
#  Return value:1 success -1 fail.
#
#  Description:execute all command listed in collection config file.
#
#
#############################################################

sub execute_cmdlist{
	my ($pkg,$cmd_inf,$err_inf)=@_;
	my $r_cmd_list=$cmd_inf;

	#----------------------------------------------
	# if there is only one item in command list
	# we have to change the hash stucture here.
	#----------------------------------------------
	if(exists $r_cmd_list->{'name'}){
		delete $r_cmd_list->{'name'};
		%cmd_list=("1"=>$r_cmd_list);
	}
	else{
		if(exists $r_cmd_list->{'id'}){
			%cmd_list=("1"=>$r_cmd_list);
		}
		else{
			%cmd_list=%$r_cmd_list;
		}
	}
	#----------------------
	# add $share_hdl 
	#----------------------
	my $share_hdl;
#modify by jzw 20041101
	my @err_file,$err_count=0;
print "\n###### NORMAL GET FILE START ######\n";
	foreach $cmd_index (sort{$a<=>$b} keys %cmd_list){
#print "\n######cmd_index is :$cmd_index######\n";
		my $r_current_cmdinf=$cmd_list{$cmd_index};
		$r_current_cmdinf->{'Ftp_state'} = 0;
		my $error_tag = $r_current_cmdinf->{'Error_tag'};
		my $flow_tag = $r_current_cmdinf->{'Flow_tag'};
		
		DBIs::Trace("Current Step: $cmd_index");
		my ($return_code,$return_msg,$share_handle)=$pkg->execute_current_cmd($r_current_cmdinf,$err_inf,$error_tag,$share_hdl);
		$share_hdl=$share_handle;
		DBIs::Trace("Step $cmd_index: $return_code");

		#---------------------------------------------------
		# serious error, we must interrupt current work flow 
		# and return back. need trace here.
		#---------------------------------------------------
	        my $err_msg=$return_msg." File:".__FILE__."\t Line:".__LINE__."\n";
                if (($return_code==1)){
                    next;       
	        } 
                if (($return_code==-2)){
#modify by jzw 20041101 for error repeat get;
			$err_count = $err_count + 1;
#print "\n###### remotefile is:$r_current_cmdinf->{'remotefile'} ###########\n";
			@err_file[$err_count] = $cmd_list{$cmd_index};
#modify by wengzy  for error skip
#                    next;       
                   #$return_code=check_return_code($return_code,$err_inf,$return_msg);
		   #print "return_code=$return_code \n";
                }       
		if (($return_code==-1)){
			#modify by wengzy  for error skip
			    next;       
			if ($flow_tag =~ /next/i) {
				DBIs::Trace("\n\nWorkFlow is next ...\n");
				next;
			}
			else {
				#return (-1,$err_msg)
			}
                }
                print "\n###### NORMAL GET FILE END ######\n";
#print "\n###### ERR FILE IS######\n";
#print Dumper(@err_file);	
		my $i;
		if(@err_file>0){
print "\n###### GET ERRFILE AGAIN START######\n";
	        	DBIs::Trace("Err File Get Repeat Start:");
			for ($i=1;$i<=@err_file;$i++){
#print "\n###### AGAIN r_current_cmdinf is:$err_file[$i] ######\n";
				my $r_current_cmdinf=$err_file[$i];
				$r_current_cmdinf->{'Ftp_state'} = 1;
#print "\n######r_current_cmdinf is ######################\n";
#print Dumper($r_current_cmdinf);
	                	my $error_tag = $r_current_cmdinf->{'Error_tag'};
	                	my $flow_tag = $r_current_cmdinf->{'Flow_tag'};
	
	                	DBIs::Trace("Current Step: $cmd_index");
	                	my ($return_code,$return_msg,$share_handle)=$pkg->execute_current_cmd($r_current_cmdinf,$err_inf,$error_tag,$share_hdl);
				$share_hdl=$share_handle;
	                	DBIs::Trace("Step $cmd_index: $return_code");
				my $err_msg=$return_msg." File:".__FILE__."\t Line:".__LINE__."\n";
	                	if (($return_code==1)){
	                    	next;
	                	}
	                	if (($return_code==-2)){
	                    	next;
	                	}
	                	if (($return_code==-1)){
	                            	next;
	                        	if ($flow_tag =~ /next/i) {
	                                	DBIs::Trace("\n\nWorkFlow is next ...\n");
	                                	next;
	                        	}
	                        	else {
	                                	#return (-1,$err_msg)
	                        	}
	                	}
			}
			DBIs::Trace("Err File Get Repeat End");
print "\n###### GET ERRFILE AGAIN END ######\n";
		}                        		
	}

        #--------------------------
        # need trace here.
	#--------------------------
	return (1,"Finish execute command list.\n");    
	
}

##############################################################
#
#  Function:execute_current_cmd
#
#  Input: current command which will be execute here.
#
#  Output:
#
#  Return value:1,success -1 error.
#
#  Description:this function is called by sub execute_cmdlist.
#
#
#############################################################

sub execute_current_cmd{
	my ($pkg,$r_current_cmdinf,$r_current_errinf,$error_tag,$share_hdl)=@_;
	my $cmd_type=lc($r_current_cmdinf->{'cmd_type'});
	my $cmd_func=$pkg->{'command_func'}{$cmd_type}{'Function'};
	print "$cmd_type\n";
	print "$cmd_func\n";

	my ($return_code,$return_msg,$return_hdl);
	if(!(defined $cmd_func)){
#		print "the type of $cmd_type is not used\n";
		return(-1," $cmd_type is not used \n");
		}
	else {
#		print "Cmd is correct, Func: $cmd_func\n";
		eval{
#print "\n##########r_current_cmdinf ##################\n";
#print Dumper($r_current_cmdinf);
		    ($return_code,$return_msg,$return_hdl)=$pkg->$cmd_func($r_current_cmdinf,$r_current_errinf,$error_tag,$share_hdl);
		};
		#---------------------------------------------
		# fail 
		# need trace here.
		#---------------------------------------------
		if($@){
			return (-1,"$@"." File:".__FILE__."\n"." Line:".__LINE__."\n");
		}
		return ($return_code,$return_msg,$return_hdl);
	}
}
##############################################################
#
#  Function:read_colcfg
#
#  Input:collection config file($colcfg)
#
#  Output:
#
#  Return value:1.return_code:1 success, -1 fail
#		2.return_msg: success or error message.
#		3.connection information
#		4.command information
#  Description: get connection and command information from collection
#		config file.
#
#
#############################################################

sub read_colcfg{
	my ($pkg,$colcfg)=@_;

	my ($col_inf,$cnt_inf,$cmd_inf,$err_inf,$err_msg);

	if(!(-r $colcfg)){
		$err_msg="Can't read file $colcfg .\n File:".__FILE__."\t Line:".__LINE__."\n";
		return (-1,$err_msg,'','');	
	}

	$col_inf=eval{XMLin("$colcfg")};
	if($@){
		$err_msg="$@ File:".__FILE__."\t Line:".__LINE__."\n";
		return (-1,$err_msg,'','');
	}
	$cnt_inf=$col_inf->{'Connect_Region'};	
	$cmd_inf=$col_inf->{'Command_Region'};
	$err_inf=$col_inf->{'Error_Region'};
	
#	print "Connect Region is:\n",Dumper($cnt_inf),"\n";
#	print "Command Region is:\n",Dumper($cmd_inf),"\n";
	return (1,"Read $colcfg success.\n" ,$cnt_inf,$cmd_inf,$err_inf);
}

##############################################################
#
#  Function:collect_data
#
#  Input:collection config file
#
#  Output:data file collected.
#
#  Return value:1 success, -1 fail.
#
#  Description: called by sub FC_TaskProcessor::execute_workflow.
#		control each step of collection.
#
#
#############################################################

sub collect_data{
	my ($pkg,$colcfg)=@_;

	DBIs::Trace("Begin collecting  data...\n");
	DBIs::Trace("Collector Config_file is: $colcfg\n");

	#-------------------------------------------
	# read collection config file,get connection 
	# information and command information
	#-------------------------------------------
	my($returncode,$return_Msg);

	($returncode,$return_msg,$pkg->{'connect_func'},$pkg->{'command_func'})=creat_method_function();
	if ($return_code == -1) {
		DBIs::Trace("Can't Read Work Method! \n");
		return -1;
	}
	
	#---------------------------------------------
	# Read Col_cfg , Split it to 3 parts
	#---------------------------------------------
	my ($return_code,$return_msg,$cnt_inf,$cmd_inf,$err_inf)=$pkg->read_colcfg($colcfg);
	DBIs::Trace("$return_msg");
	if ($return_code == -1) {
		return $pkg->move_colcfg(-1,$colcfg);
	}
	DBIs::Trace("Finished read col_cfg\n");

	#-------------------------------------------
	# connect net element
	#-------------------------------------------
	($return_code,$return_msg)=$pkg->execute_connect($cnt_inf);
	DBIs::Trace("$return_msg");
	if ($return_code == -1) {
		return $pkg->move_colcfg(-1,$colcfg);
	}
	DBIs::Trace("finished connect\n");

	#-------------------------------------------
	#send command and collect data
	#-------------------------------------------
	($return_code,$return_msg)=$pkg->execute_cmdlist($cmd_inf,$err_inf);
	DBIs::Trace("$return_msg");
	if ($return_code==-1) {
		return $pkg->move_colcfg(-1,$colcfg);
	}

	#-------------------------------------------
	# success.
	#-------------------------------------------
	DBIs::Trace("finish data collection.\n");
	return $pkg->move_colcfg(1,$colcfg);
}

##############################################################
#
#  Function:move_colcfg
#
#  Input:return_code,collection config file
#
#  Output:
#
#  Return value:return_code
#
#  Description: called by sub collect_data.
#		move collection config file($colcfg) to
#		different path according to return_code.
#
#
#############################################################

sub move_colcfg{
	my ($pkg,$return_code,$colcfg)=@_;

	#----------------------------------------
	# get colcfg's upper path.
	#----------------------------------------
	$colcfg=~/(.*)\/new/;
	my $upper_path=$1;

	if($return_code==1){
		DBIs::Trace("mv $colcfg $upper_path/success/ \n");
	        if(!(-d "$upper_path/success/")) {
                        system("mkdir $upper_path/success/");
                }
		system ("mv $colcfg $upper_path/success/");}
	if($return_code==-1){
		DBIs::Trace("mv $colcfg $upper_path/fail/ \n");
                if(!(-d "$upper_path/fail/")) {
                        system("mkdir $upper_path/fail/");
                }
		system ("mv $colcfg $upper_path/fail/");}

	return $return_code;
}
##############################################################
#
#  Function:check_return_code
#
#  Input:$err_inf
#
#  Output:
#
#  Return value:
#
#  Description:
#
#
#############################################################

sub check_return_code{
    my $return_code=shift;
    my $err_full_inf=shift;
    my $err_msg=shift;

    $err_inf=$err_full_inf->{'error'};
    foreach $err_value(values %$err_inf){;
	    if ($err_msg=~/$err_value->{'error_des'}/){;
	        if ($err_value->{'action'} eq "halt"){
	            return -1;
                }
	        return 1;
	     } 
    }
    if ($err_full_inf->{'default'} eq "next")
       { return 1;} 
    return -1; 
}


##############################################################
#
#  Function: WriteHash2Col_cfg
#
#  Input: 
#
#  Output:
#
#  Return value:
#
#  Description: Write Col_config file for Collect
#
##############################################################

sub WriteHash2Col_cfg {
        my ($template_inf,$outputfilename,$task_id) = @_;

        #---------------------------------------
        # Deal With Command Region
        #---------------------------------------

        my $command = $template_inf->{'Command_Region'}{'cmd'};
        delete $template_inf->{'Command_Region'}{'cmd'};

        if (exists $command->{'id'}) {
                delete $command->{'id'};
                $command = {"1"=>$command};
        } elsif (exists $command->{'name'}) {
                delete $command->{'name'};
                $command = {"1"=>$command};
        }
        my $Command_Region = "<Command_Region>\n";
        foreach my $id (keys %$command) {
                my $cmd_line ="\t<cmd id=\"$id\" ";
                my $cmd = $command->{$id};
                foreach my $value (keys %$cmd) {
                        $cmd_line .= "$value=\"".$cmd->{$value}."\" ";
}
                chop($cmd_line);
                $cmd_line .= "/>\n";
                $Command_Region .= $cmd_line;
        }
        $Command_Region .= "</Command_Region>\n";

        #--------------------------------------
        # Deal with Connect & Error Region
        #--------------------------------------

        my $tmpfile ="/tmp/$task_id"."_tmpfile";
        eval{XMLout($template_inf,outputfile=>"$tmpfile",rootname=>"")};
        if ($@) {
                print $@."File ".__FILE__."Line ".__LINE__."\n";
                exit;
        }
        open (READ,$tmpfile) || die "Can't open file: $tmpfile\n";
        my $Other_Region;
        while (<READ>) {
                $Other_Region .= $_;
        }
	#--------------------------------------
        # Write OutPutConfigFile
        #--------------------------------------

        open (WRITE,">$outputfilename") || die "Can't open file: $outputfilename
\n";
        print WRITE "<Collect_Config>\n";
        print WRITE $Command_Region;
        print WRITE $Other_Region;
        print WRITE "</Collect_Config>";

        close (WRITE);
        return ($outputfilename);
}

##############################################################
#
#  Function: Format_HashStruc
#
#  Input:
#
#  Output:
#
#  Return value:
#
#  Description:
#
#############################################################

sub Format_HashStruc {
        my ($pkg,$hash_ref) = @_;
        my $hash;

        if(exists $hash_ref->{'id'}){
		my $key = $hash_ref->{'id'};
                $hash={"$key"=>$hash_ref};
                delete $hash_ref->{'id'};
        }
        else{
                if(exists $hash_ref->{'name'}){
			my $key = $hash_ref->{'name'};
                        $hash={"$key"=>$hash_ref};
                        delete $hash_ref->{'name'};
                }
                else{
                        #-----------------------------------------------
                        # there are more than one steps in the work flow.
                        #-----------------------------------------------
                        $hash=$hash_ref;
                }
        }
        return ($hash);
}


##############################################################
#
#  Function: Data_filters
#
#  Input: (\@remote_file,\@local_file,$task_id,$db_para)
#	$db_para is a hash ref and it has following structure:
#	{	
#		'db_name'=> database name,
#		'server_name'=> db server name,
#		'db_user'=> user name,
#		'db_pwd' => user password
#	}
#
#  Output: (\@remote_file,\@local_file)
#
#  Return value:
#
#  Description: this fuction is used by 2 work type: MMI and FTP
#  in FTP case , $remote_file and $local_file must be defined.
#  in MMI case , the $local_file is null , and $remote_file is vendor_cmd.
#
###############################################################

sub Data_filters {
	my ($pkg,$remote_file,$local_file,$task_id,$db_para) = @_;
	my ($r,$str);
        my $db_name  = $db_para->{'db_name'};
        my $db_server  = $db_para->{'server_name'};
        my $db_usr  = $db_para->{'db_user'};
        my $db_passwd  = $db_para->{'db_pwd'};
	my $connect_str = "dbi:Informix:$db_name"."\@$db_server";
        my $db_hdl = DBI->connect($connect_str, $db_usr, $db_passwd);
	my $lock_mode = "set lock mode to wait 60";
        $db_hdl->do($lock_mode);

        my $sql = "select distinct vendor_data from dal_log where vendor_data= ? and task_id= ? and program_name=\"filecollector\"";
        my $sth =$db_hdl->prepare($sql)|| (($r=$DBI::err)&&($str=$DBI::errstr));
        if ($r) {
                $db_hdl->rollback;
                print " $r \n$str";
                exit(-1);
        }
	my (@remote_tmp,@local_tmp,@new_remotefile,@new_localfile);
	@remote_tmp = @$remote_file;
	if ($local_file) {
		@local_tmp = @$local_file;
	}
        for (my $i=0;$i<@remote_tmp;$i++) {
                my $datafile = $remote_tmp[$i];
                $sth->bind_param(1,$datafile);
                $sth->bind_param(2,$task_id);
                $sth->execute || (($r=$DBI::err) &&($str=$DBI::errstr));
                my @row_ary  = $sth->fetchrow_array;
                if ($row_ary[0]) {
                        push @new_remotefile, $datafile;
			if ($local_file) {
                        	push @new_localfile, $local_tmp[$i];
			}
                }
        }

        $db_hdl->disconnect();

	if ($local_file) {
		return (\@new_remotefile,\@new_localfile);
	}else {
		return (\@new_remotefile);
	}
}

#######################################################################
#
# Function: write_dallog
#
# Input:
#
# Output:
#
# Description:
#
#
#######################################################################

sub write_dallog {
	my ($pkg,$error_message,$col_tag,$message_class) = @_;
	
	my $v2c_map = $pkg->{'Assistant_Var'}{'v2c_map'};
	my $error_hdl = $pkg->{'ErrMessage_hdl'};
	my $db_para = $pkg->{'db_para'};
        my $common_tmp = $error_hdl->{'common'};

        my ($v2c_tmp,$dallog_msg);
        foreach my $id (keys %$v2c_map) {
                my $vendor_data = $v2c_map->{$id}{'vendor_data'};
                if ($col_tag =~ /$vendor_data/i) {
                        $v2c_tmp = $v2c_map->{$id};
                }
        }
	foreach my $key (keys %$common_tmp) {
                $dallog_msg->{$key} = $common_tmp->{$key};
                if (!($dallog_msg->{$key})) {
                        $dallog_msg->{$key} = '';
                }
        }
        foreach my $key (keys %$v2c_tmp) {
                $dallog_msg->{$key} = $v2c_tmp->{$key};
                if (!($dallog_msg->{$key})) {
                        $dallog_msg->{$key} = '';
                }
        }
        $dallog_msg->{'error_message'} = $error_message;
	$dallog_msg->{'message_class'} = $message_class;

        my $db_dbname= $db_para->{'db_name'};
        my $db_server= $db_para->{'server_name'};
        my $db_pwd= $db_para->{'db_pwd'};
        my $db_user= $db_para->{'db_user'};

        my ($return_code,$return_msg) =$error_hdl->connect_DB($db_type,$db_server,$db_dbname,$db_user,$db_pwd);
        if ($return_code < 0) {
                DBIs::Trace("Can't Connect to DB Write Dal_log !!\n$return_msg");
                return $return_code;
        }

        ($return_code,$return_msg) = $error_hdl->WritelogTbl($dallog_msg);
        if ($return_code < 0) {
                DBIs::Trace("Can't Write Dal_log !!\n$return_msg");
                return $return_code;
        }
        my $db_hdl = $error_hdl->{'db_handle'};
        $db_hdl->disconnect();
        undef($db_hdl);
        delete $error_hdl->{'db_handle'};
        return(1);
}

1;
