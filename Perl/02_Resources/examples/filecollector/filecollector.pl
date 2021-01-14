#!/opt/dc_perl/bin/perl

###############################################################################
#
#  @(#) Perl Module:  filecollector.pl
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JiaXiaoLong
#  
#  Creation Date: 2002-12-12
#
#  Last update Date: 2003/09/07
#
#  Description:This program is design to handle file interface for dc.
#
#
###############################################################################

use strict;
use Env qw(NPM_HOME);
use Getopt::Long;
use XML::Simple;
use Data::Dumper;
use Time::ParseDate;
use Date::Format;

use lib "$NPM_HOME/common/modules";

use DBIs;
use DalInstance;
use WriteDallog;

use lib "$NPM_HOME/common/mbin/filecollector/module";

use FC_PrepareColInf;
use FC_PreprocessColInf;
use FC_TaskProcessor;
use FC_GetMeasure;

#-------------------------------------------------------------
# Initialize debug trace and get arguments from command line.
#-------------------------------------------------------------
$SIG{'INT'}  = \&KillProc;
$SIG{'KILL'} = \&KillProc;
$SIG{'QUIT'} = \&KillProc;
$SIG{'TERM'} = \&KillProc;

my ($return_code,$omc_id,$ne_type,$ne_list,$task_id,$pcol_infcfg,$table,$measure,$start_time,$stop_time,$message_switch,$Assistant_Var,$cmd_line,$instance_hdl,$ins_id,$end_tag,$data_filter_tag,$filter_cmdline,$filter_instance,$rmtmp_file_tag);

#----------------------
# Get Command line
#----------------------
foreach my $arg (@ARGV) {
	if ($arg !~ /^-/) {
                $cmd_line .= " \"$arg\"";
        }
	else{
        	$cmd_line .= " $arg";
        }
}
$cmd_line = $0.$cmd_line;

#---------------------------------------------
# Get parameters From Command Line
#---------------------------------------------

my $Usage="Usage: \n".
		"-o \t [oss_label]\n".
		"-task \t [task_id]\n".
		"-f \t [config_file]\n".
		"-ne_type \t [childne type]\n".
		"-ne_list \t [childne list]\n".
		"-table_list \t [table_name_list]\n".
		"-meas_list \t [measurement_list]\n".
		"-s \t [starttime]\n".
		"-e \t [stoptime]\n".
		"-b \t [back_times]\n".
		"-n \t [message_handle on/off]\n".
		"-filter \t [filter of datfile]\n".
		"-rmtmp \t [rm the tempfile of filecol]\n";

my @option_list=("o=s","ne_type=s","ne_list=s","task=i","f=s","table_list=s","meas_list=s","s:s","e:s","b=s","n","filter","rmtmp");
my %optctl=();

($return_code,$omc_id,$ne_type,$ne_list,$task_id,$pcol_infcfg,$table,$measure,$start_time,$stop_time,$message_switch,$filter_cmdline,$rmtmp_file_tag) = GetArg(\%optctl,\@option_list);

if($return_code<0){
	print "$Usage";
    	exit(1);
}
my $ref ;
$ref->{'isMainProgram'} = 1 ;
$ref->{'omc_id'} = $omc_id;
$ref->{'task_id'} = $task_id;
$ref->{'target'} = $table;
$ref->{'scan_start_time'} = $start_time; 
$ref->{'scan_stop_time'} = $stop_time;
$ref->{'md'} = $ENV{LOCAL_HOST};
$ref->{'procedure_name'} = 'FILECOLLECTOR' ;
$ref->{'pid'} = $$ ;
$ref->{'cmd'} = $cmd_line ;
$ref->{'error_type'} = '';
$ref->{'description'} = 'FILECOLLECTOR start ...';

DBIs::Init_Trace("${task_id}_Filecol_${omc_id}","$NPM_HOME/trace/${omc_id}/FILECOL",$cmd_line, $ref);
my $trace_file = "${task_id}_Filecol_${omc_id}","$NPM_HOME/trace/${omc_id}/FILECOL";
DBIs::Trace("---------- file_collector work Now... ------------\n\n");

#----------------------------------------------
# 	Write table: Dal_instance 
#----------------------------------------------
my $ldap_hdl = LDAP_API->new();
my $mddb_para_hash = $ldap_hdl->get_mddb_attr();
$ldap_hdl = $ldap_hdl->close();

$instance_hdl = DalInstance->new(
	$mddb_para_hash->{'odbc_dsn'}, 
	USER    => $mddb_para_hash->{'db_user'},
	PASSWORD=> $mddb_para_hash->{'db_pwd'}
);
$instance_hdl->open();
my $invoker_ins_id = $instance_hdl->get_instance_id_by_task(
        $task_id,
        instance_class=>DalInstance::get_instance_class('invoker')
);

if ($invoker_ins_id) {
	DBIs::Trace("INVOKER instance_id: $invoker_ins_id\n");
	$ins_id  = $instance_hdl->get_instance_id_by_task(
		$task_id,
		instance_class=>DalInstance::get_instance_class('filecollector')
	);
	DBIs::Trace("FILECOL instance_id: $ins_id \n");
	$end_tag =0;
	if (!$ins_id) {
		my $collect_rdn = $instance_hdl->get_instance_rdn($invoker_ins_id)."/".$instance_hdl->gen_self_rdn;
		DBIs::Trace("Write FILECOL instance_id Start ...\n");
                DBIs::Trace("Collector_rdn : $collect_rdn \n");
                my $counter_ins = 5;
                while ($counter_ins) {
			$ins_id  = $instance_hdl->add(
				$collect_rdn,
				omc_id		=> $omc_id,
				task_id         => $task_id,
				instance_class=>DalInstance::get_instance_class('filecollector'),
				command_line    => $cmd_line,
                		instance_name   => 'filecollector',
                		status          => 0
			);
			DBIs::Trace("RETRY $counter_ins write \n");
                        $counter_ins -=1;
			if ($ins_id == -1) {
                                next;
                        }
                        else {
                                last;
                        }
		}
		$end_tag=1;
		$filter_instance = 0;
	}
	else {
		$filter_instance = 1;
	}
}
else {
	$filter_instance = 0;
}

if (!$filter_cmdline) {
	$data_filter_tag = $filter_cmdline;
}
else {
	$data_filter_tag = $filter_instance;
}
	
#----------------------------------
# create tmp_folder for tmpfiles
#----------------------------------

$return_code=&create_tmp_folder();

if($return_code<0){
	DBIs::Trace("Error: Can\'t create \.\/tmp_folder for tmp file \n");
  	exit(-1);
}

#---------------------------------------
# Get $Assistant_Var from config_file
#---------------------------------------
my $MeaSure_hdl = new FC_GetMeasure($pcol_infcfg,$table,$measure);
$Assistant_Var = $MeaSure_hdl->GetMeasure();
$MeaSure_hdl = $MeaSure_hdl->close();

#----------------------------
# Add Collect Time Control 
#----------------------------
if ($Assistant_Var != 1) {
	$Assistant_Var->{'start_time'} = $start_time;
	$Assistant_Var->{'stop_time'} = $stop_time;
	$Assistant_Var->{'data_filter_tag'} = $data_filter_tag;
}

#-----------------------------
# Get common info of Message 
#-----------------------------
my $common_msg;

if ($message_switch) {
	$common_msg = &GetCommonMessage($cmd_line,$ins_id,$omc_id,$task_id,$trace_file);
}
else {
	$common_msg =0;
}

#------------------------------
# Create Col_inf config File
#------------------------------
my $ColInf_prepare = new FC_PrepareColInf($omc_id,$ne_type,$ne_list,$pcol_infcfg,$task_id);
my ($col_infcfg) = $ColInf_prepare->create_col_inf();
$ColInf_prepare = $ColInf_prepare->close();

#---------------------
# Create Task Files
#---------------------
DBIs::Trace("Start creating taskfiles ...\n\n");
#print Dumper($col_infcfg);exit;
my $ColInf_preprocess = new FC_PreprocessColInf;
my ($result,$r_taskfile_list) = $ColInf_preprocess->create_taskfile_list($col_infcfg,$task_id);

DBIs::Trace("Finish creating taskfiles...\n\n");

if ($result==-1){
	$ColInf_preprocess->move_col_inf(-1,$col_infcfg);
    	DBIs::Trace("Create taskfile list fail\n",1,1030210,$task_id);
	if($invoker_ins_id) {
		$instance_hdl->update($ins_id,$end_tag,status=>1);
		$instance_hdl = $instance_hdl->close();
	}
    	exit(1);
}

#----------------------
# execute task files
#----------------------
my @taskfile_list=@$r_taskfile_list;

foreach my $taskfile (@taskfile_list) {
	DBIs::Trace("---------------------the next task--------------------------\n");
    	DBIs::Trace("TaskFile:\n$taskfile \n\n");
    	my $task_processor = new FC_TaskProcessor($Assistant_Var,$common_msg,$mddb_para_hash);
    	my $result = $task_processor->task_process($taskfile);
	$task_processor = $task_processor->close();
	DBIs::Trace("TaskFile:\n$taskfile Successfully\n");
}

#-----------------------------------
# move collection information file. and update the status in dal_instance
#-----------------------------------

$ColInf_preprocess->move_col_inf(1,$col_infcfg);
$ColInf_preprocess = $ColInf_preprocess->close();

if ($invoker_ins_id) {
	$instance_hdl->update($ins_id,$end_tag,status=>0) ;
}
$instance_hdl->close();
DBIs::End_Trace;

#----------------------------------------------------------
# if set '-rmtmp' , filecol will delete the intercurrent configfile
#----------------------------------------------------------

if ($rmtmp_file_tag) {
	&rm_temp_config_file($task_id);
}

DBIs::Trace("---------- file_collector work End... ------------\n\n");

exit(0);

#-------------------
#   Program End 
#-------------------

#######################################################################
#
# Function: GetArg
#
# Input:
#
# Output:
#
# Description: Get arguments from command line
#
#
#######################################################################

sub GetArg{
	my ($r_optctl,$r_option_list)=@_;
    	my @option_list=@$r_option_list;
    	my $r=Getopt::Long::GetOptions($r_optctl,@option_list);

    	if (!$r){
		print "There is wrong when get options \n $Usage";
		return -1;
    	}

    	my $omc_id=$r_optctl->{'o'};
	my $ne_type=$r_optctl->{'ne_type'};
    	my $ne_list=$r_optctl->{'ne_list'};
    	my $task_id=$r_optctl->{'task'};
    	my $pcol_infcfg=$r_optctl->{'f'};
	my $table=$r_optctl->{'table_list'};
	my $measure=$r_optctl->{'meas_list'};
    	my $start_time=$r_optctl->{'s'};
    	my $stop_time=$r_optctl->{'e'};
    	my $back_time=$r_optctl->{'b'};

	if($ne_list && $ne_type) {
		print "Please choose parameters in 'ne_type' and 'ne_list' \n";
		return -1;
	}
	if(!$omc_id || !$task_id || !$pcol_infcfg){
		print "Need more arguments!!\n";
		return -1;
    	}
    	if(!(-e $pcol_infcfg)){
		print "$pcol_infcfg doesn't exist.\n";
		return -1;
    	}
	if (!($start_time) && !($stop_time) && !($back_time)) {
		my $time_code = parsedate("today");
		$stop_time = time2str("%Y-%m-%d %H:%M:00",$time_code);
		$time_code -=5*3600;
		$start_time = time2str("%Y-%m-%d %H:%M:00",$time_code);
	}
	elsif ($back_time && !($stop_time) && !($start_time)) {
		my $time_code = parsedate("today");
                $stop_time = time2str("%Y-%m-%d %H:%M:00",$time_code);
		$back_time =~ /(\d+)(\w)/;
                my $num = $1;
                my $time_unit = $2;
                if ($time_unit =~ /d/i) {
                        $time_unit = 24*3600;
                }
                elsif ($time_unit =~ /h/i) {
                        $time_unit = 3600;
                }
                elsif ($time_unit =~ /m/i) {
                        $time_unit = 60;
                }
                else {
                        $time_unit = 3600;
                }
                my $start_code = $time_code - $num*$time_unit ;
                $start_time = time2str("%Y-%m-%d %H:%M:00",$start_code);
	}
	elsif ($stop_time && $back_time) {
		my $stop_code = parsedate($stop_time);
		$back_time =~ /(\d+)(\w)/;
		my $num = $1;
		my $time_unit = $2;
		if ($time_unit =~ /d/i) {
			$time_unit = 24*3600;
		}
		elsif ($time_unit =~ /h/i) {
			$time_unit = 3600;
		}
		elsif ($time_unit =~ /m/i) {
			$time_unit = 60;
		}
		else {
			$time_unit = 3600;
		}
		my $start_code = $stop_code - $num*$time_unit ;
		$start_time = time2str("%Y-%m-%d %H:%M:00",$start_code);
	}
	
	my $message_switch=$r_optctl->{"n"};
	if ($message_switch) {
		$message_switch=1;
	}
	else {
		$message_switch=0;
	}
	my $rm_switch = $r_optctl->{'rmtmp'};
	if ($rm_switch) {
		$rm_switch = 1;
	}
	else {
		$rm_switch = 0;
	}
	my $filter_switch = $r_optctl->{'filter'};
	if ($filter_switch) {
		$filter_switch = 1;
	}
	else { 
		$filter_switch = 0;
	}

    	return(1,$omc_id,$ne_type,$ne_list,$task_id,$pcol_infcfg,$table,$measure,$start_time,$stop_time,$message_switch,$filter_switch,$rm_switch);
}

#######################################################################
#
# Function: create_tmp_folder
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub create_tmp_folder {
    	if(!(-d "/tmp/tmp_folder")){
		system("mkdir /tmp/tmp_folder");
		if(!(-d "/tmp/tmp_folder")){
	    		return -1;
		}
    	}
    	return 1;
}

#######################################################################
#
# Function: KillProc
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub KillProc {
  	DBIs::Trace("Create taskfile list fail\n",1,1030211,$task_id);
  	DBIs::End_Trace;
        print "Interrupted by user!\n";
    	exit (2);
}

#######################################################################
#
# Function: GetHandleMessage 
#
# Input: ($task_id,$omc_id,$pcol_infcfg,$measure_type,$cmd_line) 
#
# Output:  a handle of WriteDallog
#
# Description: 
#
#
#######################################################################

sub GetCommonMessage {
	my ($cmd_line,$ins_id,$omc_id,$task_id,$trace_file) = @_;

	#--------------------------------------
	# Create Message Common Part
	#--------------------------------------

	my $CommonMessage = {};

	$CommonMessage->{'task_id'} = $task_id;
	$CommonMessage->{'instance_id'} = $ins_id;
	$CommonMessage->{'program_name'} = 'filecollector';
	$CommonMessage->{'cmd_line'} = $cmd_line;
	$CommonMessage->{'omc_id'} = $omc_id;
	$CommonMessage->{'trace_file'} = $trace_file;

	return ($CommonMessage);
}

#######################################################################
#
# Function: rm_temp_config_file
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub rm_temp_config_file {
	my ($task_id) = @_;
	my $file_path = $NPM_HOME."/common/mbin/filecollector/config/";
	my @file_dir = ("col_inf","task","col_cfg");
	my @stat_dir = ("fail","new","success");
	for(@file_dir) {
		my $level1_dir = $_;
		my $curr_dir = $file_path.$level1_dir."/";
		for(@stat_dir) {
			my $level2_dir = $_;
			my $dest_dir = $curr_dir.$level2_dir."/";
			my $cmd = "rm -r $dest_dir"."*".$task_id."*";
			DBIs::Trace("$cmd \n");
			system("$cmd");
		}
	}
}
