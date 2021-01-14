package FC_TaskProcessor;

###############################################################################
#
#  @(#) Perl Module:FC_TaskProcessor
#
#  Author(s): JiaXiaoLong
#  
#  Creation Date: 2002/12/18
#
#  Description:This module is design to handle task file - a scheme for data 
#		data file collection.
#
###############################################################################

use Env qw(NPM_HOME);
use XML::Simple;
use Data::Dumper;

use FC_Collector;

use lib "$NPM_HOME/common/modules";
use DBIs;
use WriteDallog;

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
#  Description:create taskprocessor
#
#
#############################################################

sub new{
	my ($pkg,$Assistant_Var,$common_msg,$db_para) = @_;
	my $taskprocessor=bless{
		'Assistant_Var' => $Assistant_Var,
		'common_msg' => $common_msg,
		'db_para' => $db_para
	},$pkg;
	return $taskprocessor;
}

##############################################################
#
#  Function:read_tskcfg
#
#  Input:task config file ($tskcfg)
#
#  Output:
#
#  Return value:
#		return code: 1 success ; -1 fail
#		structure of prepare and analysis region,
#		structure of workflow region, structure of prime
#		command region.
#		
#
#  Description:
#
#
#############################################################

sub read_tskcfg{
	my $pkg=shift;
	my $tskcfg=shift;
	my ($tsk_inf,$workflow,$template);
	
	#-------------------------------------------------
	# open task file. It is necessary to write trace 
	# here if we can't read task file.
	#-------------------------------------------------
	if(!(-r $tskcfg)){
		my $err_msg="Can't read file $tskcfg .\n File:".__FILE__."\t Line:".__LINE__."\n";
		DBIs::Trace("$err_msg");
		return (-1,'','','');
	}

	$tsk_inf=eval{XMLin("$tskcfg")};
	if($@){
		my $err_msg="$@ File:".__FILE__."\t Line:".__LINE__."\n";
		DBIs::Trace("$err_msg");
		return (-1,'','','');
	}
	$workflow=$tsk_inf->{'Task_Information'}{'Task_Flow_Region'};
	#print "workflow:\n",Dumper($workflow);
	$template=$tsk_inf->{'Task_Information'}{'Collect_Config_Template'};
	#print "template:\n",Dumper($template);
	my $vendor_path = $tsk_inf->{'Vendor_path'};
	my $vendor_module = $tsk_inf->{'Vendor_module'};

	DBIs::Trace("read $tskcfg success.\n");

	return(1,$workflow,$template,$vendor_path,$vendor_module);
}

##############################################################
#
#  Function:execute_workflow
#
#  Input: structure of workflow($workflow), AssisVar_hdl
#	  structure of template and structure of prime commands.
#
#  Output:
#
#  Return value:return_code: 1 success -1 fail.
#
#  Description:this function reads task config file and calls 
#		AssisVar_hdl to finish each step.
#
#############################################################

sub execute_workflow{
	my ($pkg,$workflow,$vendor_hdl,$template)=@_;
	my ($return_code,$err_msg,$tmp_step_list,$step_list);

	#--------------------------------------------------
	# If there is only one step in work flow.It is necessary 
	# to change the step list structure here.
	#--------------------------------------------------
	$tmp_step_list=$workflow->{'Task'};
	$step_list = $pkg->Format_HashStruc($tmp_step_list);
	
	#--------------------------------------------------
	# execute each step here.
	#--------------------------------------------------
	foreach $step_index (sort{$a<=>$b} keys %$step_list){
		my $current_step_inf=$step_list->{"$step_index"};
		my $action=$current_step_inf->{'action'};
		my $child_part_step = $current_step_inf->{'step'};
		$child_part_step=$pkg->Format_HashStruc($child_part_step);
		my $col_file =  $current_step_inf->{'file'};

		#-----------------------------------------------
		# if action is 'assis_var' , $vendor_hdl will call fuction
		#  to write $vendor_hdl->{'Assistant_Var'};
		#-----------------------------------------------
		if($action=~/assis_var/i){
			foreach my $step_id (sort{$a<=>$b} keys %$child_part_step){
				my $step_info = $child_part_step->{$step_id};
				my $input = $step_info->{'input'};
				$input =$pkg->Format_HashStruc($input);
				my $output = $step_info->{'output'};
				$output =$pkg->Format_HashStruc($output);
				my $function = $step_info->{'fuction'};

                        	DBIs::Trace("Action: Assis_var\n");
                        	DBIs::Trace("Func: $function()\n");

				my $Assis_Var = $vendor_hdl->{'Assistant_Var'};
				my $Assis_Var_tmp = eval(Dumper($Assis_Var));
				my $db_para = eval(Dumper($vendor_hdl->{'db_para'}));
				delete $vendor_hdl->{'Assistant_Var'};
				delete $vendor_hdl->{'db_para'};
				($return_code,$Assis_Var)= $vendor_hdl->$function($input,$output,$Assis_Var,$db_para);
				if($return_code!=1){
					DBIs::Trace("task_step: $step_index	action: $function FAIL \n");
					return -1;
				}
				if (!$Assis_Var) {
					$Assis_Var= $Assis_Var_tmp;
				}
				$vendor_hdl->{'Assistant_Var'} = $Assis_Var;
				$vendor_hdl->{'db_para'} = $db_para;

				DBIs::Trace("task_step: $step_index	action: $function SUCCESS \n");
			}
		}

		#---------------------------------------------------
		# if $action is 'collect' , $vendor_hdl will call fuction 
		#  'collect_data' to finished collecting ...
		#---------------------------------------------------
		if($action=~/collect/i){
			DBIs::Trace("Action: Collect\n");
			my ($colcfg_ref,$cmd_region_temp,$counter);
			$colcfg_ref = eval(Dumper($template));
			$cmd_region_temp = $colcfg_ref->{'Command_Region'}{'Template'};
			delete $colcfg_ref->{'Command_Region'}{'Template'};
			$counter=1;

			#-----------------------------------
			# Write Col_cfg with Assistant_Var
			#-----------------------------------
			foreach my $step_id (sort{$a<=>$b} keys %$child_part_step){
				my $AssisVar = $vendor_hdl->{'Assistant_Var'};
   				my $step_info = $child_part_step->{$step_id};
				($colcfg_ref,$counter) = $pkg->WriteCfg_ref($colcfg_ref,$cmd_region_temp,$step_info,$counter,$AssisVar);
			}
			eval{XMLout($colcfg_ref,outputfile=>"$col_file",rootname=>"Collect_Config")};
        		if($@){
                		DBIs::Trace("collect step error.\n$@\n");
                		return -1;
        		}
			$pkg->format_xmlfile($col_file);
			eval{XMLin($col_file)};
			if($@) {
				DBIs::Trace("File: $col_file ERROR on XMLin() !!! \n");
				return -1;
			}
			DBIs::Trace("File: $col_file \n");
			DBIs::Trace("Write ColCfg_file successfully! now collecting...\n\n");

			#---------------------------------
			# Collect data by the $col_file
			#---------------------------------
			($return_code,$err_msg)=$vendor_hdl->collect_data($col_file);
			if($return_code!=1){
				DBIs::Trace("task_step: $step_index	FAIL \n");
				DBIs::Trace("Error: $err_msg \n",1);
				return -1;
			}
			DBIs::Trace("task_step: $step_index	action: collect data  SUCCESS \n");
		}	
	}

	#------------------------------------------------------------
	# distory all Handles of vendor_modules and Net::Telnet... 
	#------------------------------------------------------------
	my $connect_hdl = $vendor_hdl->{'connect_handle'};
	if ($connect_hdl =~ /Telnet/) {
		$connect_hdl = $connect_hdl->close();
	}
	my $writelog_hdl = $vendor_hdl->{'ErrMessage_hdl'};
	if ($writelog_hdl =~ /WriteDallog/) {
		$writelog_hdl = $writelog_hdl->close();
	}
	$vendor_hdl = $vendor_hdl->close();

	#---------------------------
	# Collector Success.
	#---------------------------
	DBIs::Trace("execute task workflow success \n");
	return 1;
}

##############################################################
#
#  Function:task_process
#
#  Input:task file
#
#  Output:
#
#  Return value:1 success,-1 error.
#
#  Description: this function controls each step of data file 
#		collection.The main steps are: filling template file
#		to create configfile,collecting data, analysising data 
#		collected and creating new command,etc.
#
#############################################################

sub task_process{
	my $pkg=shift;
	my $tskcfg=shift;

	my $Assistant_Var = $pkg->{'Assistant_Var'};
	my $common_msg = $pkg->{'common_msg'};
	my $db_para = $pkg->{'db_para'};
	delete $pkg->{'common_msg'};
	delete $pkg->{'Assistant_Var'};
	delete $pkg->{'db_para'};

	my ($return_code,$workflow,$template,$vendor_path,$vendor_module,$vendor_hdl);
	DBIs::Trace("Start processing task file: $tskcfg...\n\n");

	#----------------------------------------------
	# read task file, get task flow ¡¢collection 
	# config template and prime commands.
	#----------------------------------------------

	($return_code,$workflow,$template,$vendor_path,$vendor_module)=$pkg->read_tskcfg($tskcfg);
	if($return_code!=1){
		DBIs::Trace("Read taskfile: $tskcfg error. \n");
		return $pkg->move_tskcfg(-1,$tskcfg);
	}
	DBIs::Trace("Read taskfile: $tskcfg successfully. \n");

	#----------------------------------------------
	# Create Vendors module Handle
	#----------------------------------------------
	my $WriteDallog_hdl;
	if ($common_msg) {
		$WriteDallog_hdl = WriteDallog->new($common_msg);
	}
	else {
		$WriteDallog_hdl =0;
	}
	eval{
		push @INC,$vendor_path;
		require "$vendor_module.pm";
		$vendor_hdl = $vendor_module->new($Assistant_Var,$WriteDallog_hdl,$db_para);
	};
	if ($@) {
		DBIs::Trace("Create objects of $vendor_module.pm fail:$@"." FILE: ".__FILE__." Line:".__LINE__."\n",1,1030214,$pkg->{'task_id'});
		exit(-1);
	}

	#---------------------------------------------------
	# execute each step of workflow
	#---------------------------------------------------
	while(1){
		$return_code=$pkg->execute_workflow($workflow,$vendor_hdl,$template);
		if($return_code!=1){
			DBIs::Trace("Execute task workflow fail.\n");
			return $pkg->move_tskcfg(-1,$tskcfg);
		}

		#---------------------------------------------------
		# success.It is necessary to write trace here.
		#---------------------------------------------------
		DBIs::Trace("Execute taskfile $tskcfg successfully \n");
		return $pkg->move_tskcfg(1,$tskcfg);
	}
}

##############################################################
#
#  Function:move_tskcfg
#
#  Input:return_code, task config file
#
#  Output:
#
#  Return value:return_code
#
#  Description:called by sub task_process
#		move task config file($tskcfg) to 
#		different path according to return_code
#
#
#############################################################
sub move_tskcfg{
 	my ($pkg,$return_code,$tskcfg)=@_;

	#----------------------------------------
	# get tskcfg's upper path.
	#----------------------------------------
	$tskcfg=~/(.*)\/new/;
	my $upper_path=$1;

	if($return_code==1){
		DBIs::Trace("mv $tskcfg $upper_path/success/ \n");
                if(!(-d "$upper_path/success/")) {
                        system("mkdir $upper_path/success/");
                }
		system ("mv $tskcfg $upper_path/success/");
	}
	if($return_code==-1){
		DBIs::Trace("mv $tskcfg $upper_path/fail/ \n");
		if(!(-d "$upper_path/fail/")) {
                        system("mkdir $upper_path/fail/");
                }
		system ("mv $tskcfg $upper_path/fail/");}

	#need trace here.
	return $return_code;
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
 		$hash={"1"=>$hash_ref};
		delete $hash_ref->{'id'};
 	}
 	else{
 		if(exists $hash_ref->{'name'}){
 			$hash={"1"=>$hash_ref};
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
#  Function: format_xmlfile
#
#  Input:
#
#  Output:
#
#  Return value:
#
#  Description:
#
###############################################################

sub format_xmlfile {
	my ($pkg,$xmlfile) =@_;
        open (IN,$xmlfile)||die "can't open file:$xmlfile\n";
        my $tmpfile ="/tmp/$$"."_tmp_xmlfile";
        open (OUT,">$tmpfile")||die "can't open tmpfile:$tmpfile\n";
        while (<IN>) {
                my $lines = $_;
                $lines =~ s/name=\"cmd\"//;
                $lines =~ s/^\s+\<(\d+)/\t\<cmd name=\"$1\"/;
                print OUT $lines;
        }
        close (IN);
        close (OUT);
        system ("cp $tmpfile $xmlfile");
        system ("rm $tmpfile");
}

#############################################################
#
#  Function: WriteCfg_ref
#
#  Input: $colcfg_ref,$cmd_template,$step,$counter,$AssisVar_hdl
#
#  Output: $colcfg_ref
#
#  Return value:
#
#  Description: Write Collector Config_file HashStructor
#
#############################################################

sub WriteCfg_ref {
	my ($pkg,$colcfg_ref,$cmd_template,$step,$counter,$AssisVar) = @_;


	#-----------------------------------
	# Step 1: instead of constant Var
	#-----------------------------------
	my $mapping = $step->{'mapping'};
	$mapping = $pkg->Format_HashStruc($mapping);
	my $temp_id = $step->{'Template'}{'id'};
	my $cmd_temp = eval(Dumper($cmd_template->{$temp_id}));
	foreach my $map_id (sort{$a<=>$b} keys %$mapping){
		my $src_var = $mapping->{$map_id}{'src'};
		my $tgt_var = $mapping->{$map_id}{'tgt'};
		foreach my $varname (sort{$a<=>$b} keys %$cmd_temp) {
			if ($varname =~ /$src_var/i) {
				$cmd_temp->{$varname} = $tgt_var;
			}
		}
	}

	#------------------------------------
        # Step 2: instead of Assistant_Var
        #------------------------------------
	my $AssisVar_list;

	foreach my $cmd_tag (sort{$a<=>$b} keys %$cmd_temp) {
		my $cmd_body =  $cmd_temp->{$cmd_tag};	
		if ($cmd_body =~ /\[A_VAR:(\S+)\]/i) {
			$AssisVar_list->{$1} = $AssisVar->{$1};
		}
	}

	if ($AssisVar_list) {
		my $max_longth=0;
		foreach my $varname (sort{$a<=>$b} keys %$AssisVar_list) {
			my $curr_longth = @{$AssisVar_list->{$varname}};	
			if ($curr_longth >= $max_longth) {
				$max_longth = $curr_longth;
			}
		}

		for (my $i=0;$i<$max_longth;$i++) {
			my $cmd_temp_bak = eval(Dumper($cmd_temp));
			foreach my $cmd_tag (sort{$a<=>$b} keys %$cmd_temp_bak) {
				if($cmd_temp_bak->{$cmd_tag} =~ /\[A_VAR:(\S+)\]/i) {
					my @cmd_str = @{$AssisVar_list->{$1}};
					$cmd_temp_bak->{$cmd_tag} =~ s/\[A_VAR:\S+\]/$cmd_str[$i]/;
				}
			}
			$colcfg_ref->{'Command_Region'}{$counter} = eval(Dumper($cmd_temp_bak));
			$counter+=1;
		}
	}else {
		$colcfg_ref->{'Command_Region'}{$counter} = eval(Dumper($cmd_temp));
		$counter+=1;
	}

	return($colcfg_ref,$counter);
}

sub close {
        my ($pkg) = @_;

        undef($pkg);
        return($pkg);
}

1;
