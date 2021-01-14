package StdCollect;

###############################################################################
#
#  @(#) Perl Module: StdCollect
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JiaXiaoLong
#  
#  Creation Date: 2002/12/23
#
#  Last update Date: 2003/02/27
#
#  Description:
#
###############################################################################

use Net::Telnet();
use Net::FTP;
use Exporter;
use Data::Dumper;

@ISA=('Exporter');
@EXPORT=qw(col_ftp col_MMI col_MMICmd col_syscmd);

local $err_msg;


$r_handle_rcp_error=sub {
	$err_msg=shift;
	print "It is in handle_rcp_error now. \n";
	return $err_msg;
};

$r_handle_rsh_error=sub {
	$err_msg=shift;
	print "It is in handle_rsh_error now. \n";
	return $err_msg;
};

$r_handle_MMICmd_error=sub {
	$err_msg=shift;
	print "It is in handle_MMICmd_error now. \n";
	return $err_msg;
};

##############################################################
#
#  Function:col_MMI
#
#  Input:
#  Output:
#
#  Return value:
#
#  Description:
#
#############################################################

sub col_MMI{
	my $pkg=shift;
	my $r_MMI_inf=shift;
	my $r_ERR_inf=shift;
	my $error_tag = shift;
	my ($return_code,$return_msg);

	#-------------------------------------------------
	# if we don't care the result,the resultfile 
	# should be /dev/null in config file.Important!
	#-------------------------------------------------
	my $result_file=$r_MMI_inf->{'resultfile'};

	#-----------------------------------------
	# execute MMI Command
	#-----------------------------------------
	my $connect_handle=$pkg->{'connect_handle'};
	DBIs::Trace("Connect handle is $connect_handle\n");
	($return_code,$return_msg)=$pkg->col_MMICmd($connect_handle,$r_MMI_inf,$r_ERR_inf,$error_tag);

	#----------------------------------------
	# success. print result into $result_file
	#----------------------------------------
	if ($return_code==1){
		if(!open(RST,">>$result_file")){
			my $err_msg="Can't open $result_file.\n File:".__FILE__."\tLine:".__LINE__."\n";
			DBIs::Trace("Can't open $result_file\n",1,1030205,$pkg->{'task_id'});
			return (-1,$err_msg);}
		print RST $return_msg;
		close(RST);
	}

	#------------------------------------------
	# need more code here for handling $return_msg
	# need trace here.
	#------------------------------------------
	return ($return_code,$return_msg);
}
##############################################################
#
#  Function:col_MMICmd
#
#  Input:
#       1. the handle of connection (telnet or socket)
#       2. a ref of a hash which contains information for MMICmd.
#           This hash has following structure:
#         {
#               cmdline=>command line,
#               expect=>expect mark,
#      
#
#  Input: 
#	1. the handle of connection (telnet or socket)
#	2. a ref of a hash which contains information for MMICmd.
#	    This hash has following structure:
#	  {
#		cmdline=>command line,
#		expect=>expect mark,
#		except=>exception mark,
#		prepare=>some command line need pre_processing.
#		newline_mark=>the mark of a new line
#		timer=>timeout
#	  }
#
#  Output:
#
#  Return value:success (1,result msg)
#		failure (-1,serious err msg)
#		failure (-2,not serious err msg)
#		failure (-10,msg of unknown err)
#
#  Description:
#
#
#############################################################
sub col_MMICmd{

	my $pkg=shift;
	my $connect_hdl=shift;
	my $r_command_inf=shift;
	my $r_error_inf=shift;
	my $error_tag=shift;
	my $error_hdl = $pkg->{'ErrMessage_hdl'};

	my $cmd_line=$r_command_inf->{'cmdline'};
	my $expect=$r_command_inf->{'expect'};
	my $exception=$r_command_inf->{'except'};
	my $time_out=$r_command_inf->{'timer'};

	#------------------------------------------
	# $exception shouldn't be null,
	# otherwise method 'waitfor' will get nothing back. 
	#------------------------------------------
	if((!$exception) and ($exception!~'0')){$exception='DEFAULT_ERROR';}
	if((!$expect) or ($expect =~ /DEFAULT/i)){$expect="[\\\$%#>]\\s*\$";}
	
	if (ref($connect_hdl) ne "Net::Telnet") {
		my $err_msg="invalid connect_hdl\n File:".__FILE__."\t Line:".__LINE__."\n";
		DBIs::Trace("$err_msg",1,1030205,$pkg->{'task_id'});
		return (-1,$err_msg);
	}

	my $pre_errmode=$connect_hdl->errmode($r_handle_MMICmd_error);
	$err_msg=''; 	
	sleep(1);

	$connect_hdl->print($cmd_line);

	print "---------------------about waitfor-----------------\n";
	print "SEND: ",$cmd_line,"\n";
	print "WAIT: $expect|$exception","\n";
	print "TIME: $time_out \n";	
	my ($cmd_result_msg,$match)=$connect_hdl->waitfor(Match=>"/($expect|$exception)/",Timeout=>$time_out);
	print $cmd_result_msg,"\n";
	print $match;

	#------------------------------------
	# if there are $err_msg, then...
	#------------------------------------
	$connect_hdl->errmode($pre_errmode);

	if(($err_msg=~/timed\-out/) and ($error_hdl)){
		my $log_info = $err_msg." CMD: $cmd_line";
		my $re_code= $pkg->write_dallog($log_info,$cmd_line,'2102');
		if ($re_code<0) {
			DBIs::Trace("Can't send Warning Message\n");
		}
		$err_msg="\n".$err_msg."\t File:".__FILE__."\t Line:".__LINE__."\n";
		DBIs::Trace("$err_msg",1,1030205,$pkg->{'task_id'});
		return (-1,$err_msg);
	}
	elsif (($err_msg) and ($error_hdl)){
		my $log_info = $err_msg." CMD: $cmd_line";
		my $re_code= $pkg->write_dallog($log_info,$cmd_line,'2199');
		if ($re_code<0) {
			DBIs::Trace("Can't send Warning Message\n");
		}
		$err_msg="\n".$err_msg."\t File:".__FILE__."\t Line:".__LINE__."\n";
		DBIs::Trace("$err_msg",1,1030205,$pkg->{'task_id'});
		return (-1,$err_msg);
	}
	elsif (($err_msg) and !($error_hdl)) {
		$err_msg="\n".$err_msg."\t File:".__FILE__."\t Line:".__LINE__."\n";
		DBIs::Trace("$err_msg",1,1030205,$pkg->{'task_id'});
		return (-1,$err_msg);
	}

	#-----------------------------------------------------------------
	# in this case, result_data like $exception (bad data we defined)
	#-----------------------------------------------------------------
	if ($match=~/$exception/) {

		#--------------------------------------------------
		# we must clear data_buffer in Telnet_hdl for next collection.
		# and write dal_log before next collection.
		#--------------------------------------------------
		if ($error_hdl) {
			my $log_info = "$exception CMD: $cmd_line";
			my $re_code= $pkg->write_dallog($log_info,$cmd_line,'2199');
			if ($re_code<0) {
				DBIs::Trace("Can't send Warning Message\n");
			}
		}
		my $pre_errmode=$connect_hdl->errmode($r_handle_MMICmd_error);
		$err_msg='';
		sleep(1);
		my ($cmd_result_msg_tmp,$match_tmp)=$connect_hdl->waitfor(Match=>"/($expect)/",Timeout=>$time_out);
		print "$cmd_result_msg_tmp","$match_tmp\n";
		$connect_hdl->errmode($pre_errmode);
		if($err_msg) {
			$err_msg="\n".$err_msg."\t File:".__FILE__."\t Line:".__LINE__."\n";
			DBIs::Trace("$err_msg",1,1030205,$pkg->{'task_id'});
			return (-1,$err_msg);		
		}
		#----------------------------------------------------------
		# if there is $error_tag and $r_error_inf in col_cfg file,
		# filecollector will collecting retry.
		#----------------------------------------------------------
		elsif (!$err_msg and $error_tag and ($error_tag !~ /NULL/i)) {
			my @error_tag = split/,/,$error_tag;
			foreach my $key (@error_tag) {
				my $waittime = $r_error_inf->{$key}{'waittime'};
				my $body = $r_error_inf->{$key}{'body'};
				my $retry = $r_error_inf->{$key}{'retry'};

				if ($match =~ /$body/) {
					while($retry) {
						#--------------------
						# collect retry
						#--------------------
						my $pre_errmode=$connect_hdl->errmode($r_handle_MMICmd_error);
   						$err_msg='';

        					print "------------------ retry $retry -------------------\n";
						print "Wait: $waittime \nBody: $body\nRetry:$retry\n";
						print "Collecting Error: $body\n\n";
						print "Waitfor $waittime ...\n";
						sleep($waittime);
						print "Now Retrying ... \n\n";
						print "SEND: ",$cmd_line,"\n";
        					print "WAIT: $expect|$exception","\n";
        					print "TIME: ",$time_out,"\n";
						$connect_hdl->print($cmd_line);
        					my ($r_cmd_result_msg,$r_match)=$connect_hdl->waitfor(Match=>"/($expect|$exception)/",Timeout=>$time_out);
        					print $r_cmd_result_msg,$r_match;

        					$connect_hdl->errmode($pre_errmode);
						if ($r_match =~ /$exception/) {
							my $repre_errmode=$connect_hdl->errmode($r_handle_MMICmd_error);
							$err_msg='';
							my ($r_cmd_result_msg_tmp,$r_match_tmp)=$connect_hdl->waitfor(Match=>"/$expect/",Timeout=>$time_out);
        						$connect_hdl->errmode($repre_errmode);
							print "$r_cmd_result_msg_tmp","$r_match_tmp\n";
        						print "------------------ retry $retry -------------------\n";
						}
						if(!$err_msg and ($r_match=~/$expect/) and ($r_match !~/$exception/)) {
                                                        print "collect successfully\n";
							print "---------------------about waitfor-----------------\n";
                                                        return (1,$r_cmd_result_msg.$r_match);
                                                }
						$retry -=1;
					}
				}
			}
		}
		print "collect failed \n";
		print "---------------------about waitfor-----------------\n";
		return (-1,$cmd_result_msg.$match);
	}
			
	print "\ncollect successfully\n";
	print "---------------------about waitfor-----------------\n";
	return (1,$cmd_result_msg.$match);
}


##############################################################
#
#  Function:col_ftp
#
#  Input::a ref of a hash which contains information for rsh.This
#	 hash has following structure:
#		{
#		    remotehost=>hostname,
#		    username=>username,
#		    password=>password,
#		    localfile=>localfile,
#		    remotefile=>remotefile
#		    action=>put or get
#		    timer=>timeout	
#		}
# 
#
#  Output:
#
#  Return value:
#
#  Description:
#
#
#############################################################
sub col_ftp{
	my $pkg=shift;
	my $ftp_inf=shift;
	my $r_current_errinf=shift;
	my $error_tag=shift;
	my $share_handle=shift;

	my $error_hdl = $pkg->{'ErrMessage_hdl'};

	my $remotehost=$ftp_inf->{'remotehost'};
	my $usr=$ftp_inf->{'username'};
	my $passwd=$ftp_inf->{'password'};
	my $localfile=$ftp_inf->{'localfile'};
	my $remotefile=$ftp_inf->{'remotefile'};
	my $act=$ftp_inf->{'action'};
	my $timeout=$ftp_inf->{'timer'};
	my $share_tag=$ftp_inf->{'share_handle'};

	my $ftp;
	if ((ref($share_handle) eq "Net::FTP") and $share_tag) {
		$ftp = $share_handle;
	}
	else {
		$ftp=Net::FTP->new("$remotehost", Debug => 0,Timeout=>$timeout);
		if(!($ftp->login("$usr","$passwd"))){
			if ($error_hdl) {
				my $log_info = "ftp login $remotehost failed: user=$usr,password=$passwd";
				my $re_code = $pkg->write_dallog($log_info,$remotefile,'2110');
				if ($re_code<0) {
 					DBIs::Trace("Can't Write dal_log\n");
				}
			}
			my $err_msg="ftp $remotehost failed: user=$usr,password=$passwd \n"."\t File:".__FILE__."\t Line:".__LINE__."\n";
			DBIs::Trace("$err_msg",1,1030206,$pkg->{'task_id'});
			return (-1,$err_msg);
		}
		$ftp->binary();
		DBIs::Trace("Translate Type: Binary \n");
	}
	if($act eq "get"){
		my $getfile=$ftp->get($remotefile,$localfile);
		if($getfile eq $localfile){
			#$ftp->close();
			DBIs::Trace("get $remotefile success \n");
			return (1,"get $remotefile success \n",$ftp);
		}
		else{
			DBIs::Trace("get $remotefile fail \n");
			if ($error_hdl) {
				my $log_info = "ftp $remotehost get file: $remotefile fail!  user=$usr,password=$passwd";
				my $re_code = $pkg->write_dallog($log_info,$remotefile,'2107');
				if ($re_code<0) {
	                        	DBIs::Trace("Can't Write dal_log\n");
       		        	}
			}
			my $err_msg="get $remotefile fail \n"."\t File:".__FILE__."\t Line:".__LINE__."\n";
			DBIs::Trace("$err_msg",1,1030207,$pkg->{'task_id'});
			$ftp->close();
			return (-2,$err_msg);
		}
	}
	if($act eq "put"){
		my $putfile=$ftp->put($localfile,$remotefile);
		if($putfile eq $remotefile){
			DBIs::Trace("put $localfile success \n");
			#$ftp->close();
			return (1,"put $localfile success \n",$ftp);
		}
		else{
			DBIs::Trace("put $localfile fail \n");
			if ($error_hdl) {
				my $log_info = "ftp $remotehost put file: $localfile fail!  user=$usr,password=$passwd";
 				my $re_code = $pkg->write_dallog($log_info,$remotefile,'2108');
 				if ($re_code<0) {
 					DBIs::Trace("Can't send Warning Message\n",1);
				}
			}
			$ftp->close();
			my $err_msg="put $localfile fail \n"."\t File:".__FILE__."\t Line:".__LINE__."\n";
			DBIs::Trace("$err_msg",1,1030208,$pkg->{'task_id'});
			return (-1,$err_msg);
		}
	}
	if($act eq "mget"){
 		my ($return_val,$msg,$handle)= mget($ftp,$ftp_inf,$error_hdl);
       		#$ftp->close();
 		return ($return_val,$msg,$handle);
	}
}

##############################################################
#
#
#  Function:mget
#
#  Input:
#
#
#  Return value:
#
#  Description:
#
#
###############################################################

sub mget {
	my ($ftp,$input,$error_hdl) = @_ ;

	my $remotehost=$input->{'remotehost'};
	my $usr=$input->{'username'};
	my $passwd=$input->{'password'};

	my $remotepath=$input->{'remotepath'};
        my $remotefile=$input->{'remotefile'};
        my $localpath=$input->{'localpath'};
	if ($localpath !~ /\/$/) {
		$localpath .= "/";
	}
        my $tmp_localfile=$input->{'localfile'};
	$tmp_localfile = $localpath.$tmp_localfile;
        my $time_out=$input->{'timer'};

	$ftp->cwd($remotepath);
	$file_list=$ftp->ls;

	foreach $file (@$file_list) {
        	my $localfile = $tmp_localfile.$file;
           	if ($file=~/$remotefile/){
             		my $getfile=$ftp->get($file,$localfile);
              		if($getfile ne $localfile) {
				my $log_info = "ftp $remotehost get file: $file fail!  user=$usr,password=$passwd";
				DBIs::Trace("$log_info\n");
				if ($error_hdl) {
 					my $re_code = $pkg->write_dallog($log_info,$remotefile,'2107');
 					if ($re_code<0) {
 						DBIs::Trace("Can't send Warning Message\n",1);
					}
				}
                	}
                	else {
                		DBIs::Trace("file:$file get successfully!\n");
                	}
		}
       }
       return (1,"mget successfully!",$ftp);
}

##############################################################
#
#
#  Function: col_syscmd
#
#  Input:
#
#
#  Return value:
#
#  Description:
#
#
###############################################################

sub col_syscmd {
	my ($pkg,$input_ref,$err_inf,$err_tag) = @_;

	my $sys_cmd = $input_ref->{'cmdline'};
	my $Flow_tag = $input_ref->{'Flow_tag'};

	#print "System CMD: $sys_cmd \n\n";
	DBIs::Trace("System CMD: $sys_cmd \n\n");
	my $return_code = system($sys_cmd);
	if ($return_code ==0) {
		return (1,"System CMD: $sys_cmd Successfully\n");
	}else {
		return (-1,"CMD: $sys_cmd failed !!! \n");
	}
}

#############################################################################
#
# Function: trans_string2hex
#
#  Input: string
#
#  Output:
#
#  Return value:hexstring
#
#  Description:Control marks will be escaped when they are written in xml file.
#               This function will resume that translation.
#
#
#############################################################################
sub trans_string2hex{
        my $string=shift;
        #print "--- $string--\n";
        my @elements=split /\\x/,$string;
        my $hexstring;
        shift(@elements);

        foreach $element (@elements){
                if(defined $element){
                        my $trans1_element=hex($element);
                        my $trans2_element=pack "c*", $trans1_element;
                #       print "trans2 is $trans2_element \n";
                        $hexstring=$hexstring.$trans2_element;
                }
        }
        return $hexstring;
}

1;
