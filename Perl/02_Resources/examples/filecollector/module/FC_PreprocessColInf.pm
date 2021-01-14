package FC_PreprocessColInf;

###############################################################################
#
#  @(#) Perl Module:FC_PreprocessColInf
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JiaXiaoLong
#  
#  Creation Date: 2002/12/16
#
#  Last update Date: 2003/02/24
#
#  Description:This module is used to create task files from collection
#		information config file.
#
###############################################################################

use Env qw(HOME NPM_HOME);

use XML::Simple;
use Time::ParseDate;
use Date::Format;
use Data::Dumper;

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
#  Description:
#
#
#############################################################

sub new{
	my $pkg=shift;
	my $prepareColInf=bless{},$pkg;
	return $prepareColInf;
} 

##############################################################
#
#  Function:create_taskfile_list
#
#  Input: collection information config ($col_infcfg), task id
#
#  Output:
#
#  Return value:return_code: 1 success, -1 error
#		ref of task files list
#
#  Description:
#
#
#############################################################

sub create_taskfile_list{
	my ($pkg,$col_infcfg,$task_id)=@_;

	#-----------------------------------
	# Read Colinf_cfg file and Create env hash.
	#-----------------------------------
	my ($CN_Var,$PN_Var,$T_Var,$C_Var,$task_file,@taskfile_list);
	my ($vendor_path,$vendor_module);

	my $colinf_ref = XMLin($col_infcfg);
	$CN_Var = $colinf_ref->{"Prime_col_inf"}{"Child_Ne_Var"};
	$PN_Var = $colinf_ref->{"Prime_col_inf"}{"Parent_Ne_Var"};
	$T_Var = $colinf_ref->{"Prime_col_inf"}{"Task_Information"}{"Task_Var"};
	$task_file = $colinf_ref->{"Prime_col_inf"}{"Task_Information"}{"Task_Config"};
	$vendor_path = $colinf_ref->{"Prime_col_inf"}{"Vendor_path"};
	$vendor_module = $colinf_ref->{"Prime_col_inf"}{"Vendor_module"};
	$vendor_path ="<Vendor_path>".$vendor_path."</Vendor_path>\n";
	$vendor_module ="<Vendor_module>".$vendor_module."</Vendor_module>\n\n";

	$C_Var->{"HOME"}=$HOME;
	$C_Var->{"NPM_HOME"}=$NPM_HOME;
	$C_Var->{"TASK_ID"}=$task_id;
	$C_Var->{'DATE'}=time2str("%Y%m%d",parsedate("today"));
	$C_Var->{'TIME'}=time2str("%T",parsedate("today"));

	#-----------------------------------
	# Create TASK Template File
	#-----------------------------------
	open (READ,$col_infcfg) || die "Can't open file:$col_infcfg\n"."File: ".__FILE__."Line ".__LINE__."\n";
	my $col_inf_lines;
	while (<READ>) {
                $col_inf_lines .= $_;
        };
	close(READ);
        $col_inf_lines =~ /(\<Task_Information.*\<\/Task_Information\>)/s;
	my $task_template_lines = "<TASK_FILE>\n\t".$vendor_path."\t$vendor_module\t".$1."\n</TASK_FILE>\n";

	foreach my $t_var_key (keys %$T_Var) {
		foreach my $pn_var_key (keys %$PN_Var) {
			my $pn_var_value = $PN_Var->{$pn_var_key};
			$T_Var->{$t_var_key} =~ s/\[PN_VAR:$pn_var_key\]/$pn_var_value/ig;
			$task_template_lines =~ s/\[PN_VAR:$pn_var_key\]/$pn_var_value/ig;
			$task_file =~ s/\[PN_VAR:$pn_var_key\]/$pn_var_value/ig;
		} 
		foreach my $c_var_key (keys %$C_Var) {
			my $c_var_value = $C_Var->{$c_var_key};
			$T_Var->{$t_var_key} =~ s/\[$c_var_key\]/$c_var_value/ig;
			$task_template_lines =~ s/\[$c_var_key\]/$c_var_value/ig;
			$task_file =~ s/\[$c_var_key\]/$c_var_value/ig;
		}
		$task_template_lines =~ s/\[T_Var:$t_var_key\]/$T_Var->{$t_var_key}/ig;
		$task_file =~ s/\[T_Var:$t_var_key\]/$T_Var->{$t_var_key}/ig;
	}

	#-------------------------
	# Write Task_file list 
	#-------------------------
	DBIs::Trace("Task file :\n");
	$CN_Var = $pkg->Format_HashStruc($CN_Var);

	#------------------------------------------------
	# in this case, we needn't collect child_ne 
	# and the taskfile is only for OMC 
	#------------------------------------------------
	if (!defined (%$CN_Var)) {
		DBIs::Trace("$task_file\n");
		open (WRITE,">$task_file") or die "Can't open Taskfile: $task_file ! File: ".__FILE__." Line ".__LINE__."\n";
		print WRITE $task_template_lines;
                close(WRITE);
                eval{XMLin($task_file)};
                if ($@) {
                        DBIs::Trace("File: $task_file is ERROR for XMLin() !!!\n");
                }
                push @taskfile_list,$task_file;
		return (1,\@taskfile_list);
	}
	foreach my $cn_var_key (keys %$CN_Var) {
		my $task_file_tmp = $task_file;
		my $task_line_tmp = $task_template_lines;
		my $cn_var_value = $CN_Var->{$cn_var_key};
		foreach my $key (keys %$cn_var_value) {
			my $value = $cn_var_value->{$key};
			$task_line_tmp =~ s/\[CN_VAR:$key\]/$value/ig;
			$task_file_tmp =~ s/\[CN_VAR:$key\]/$value/ig;
		}
		DBIs::Trace("$task_file_tmp\n");
		if ($task_line_tmp =~ /\[(\w+)VAR:(\w+)\]/i) {
			if ($1 !~ /A/i) {
				print "Strange $1VAR: $2 !!! \n\n";
			}
		}
		open (WRITE,">$task_file_tmp") || die "Can't open file: $task_file\n"."File: ".__FILE__."Line ".__LINE__."\n";
		print WRITE $task_line_tmp;
		close(WRITE);
		eval{XMLin($task_file_tmp)};
		if ($@) {
			DBIs::Trace("File: $task_file_tmp is ERROR for XMLin() !!!\n");
		}
		push @taskfile_list,$task_file_tmp;
	}

	return (1,\@taskfile_list);
}

##############################################################
#
#  Function:move_col_inf
#
#  Input:
#
#  Output:
#
#  Return value:
#
#  Description: 
#
#
###############################################################

sub move_col_inf{
	my ($pkg,$return_code,$col_inf)=@_;

    	$col_inf=~/(.*)\/new/;
    	my $upper_path=$1; 
   
 	if($return_code==1){
		DBIs::Trace("mv $col_inf $upper_path/success/ \n");
		if(!(-d "$upper_path/success/")) {
			system("mkdir $upper_path/success/");
		}
		system("mv $col_inf $upper_path/success/");
		return(1,"success\n");
	}
	if($return_code==-1){
		DBIs::Trace("mv $col_inf $upper_path/fail/ \n");
		if(!(-d "$upper_path/fail/")) {
			system("mkdir $upper_path/fail/");
		}
		system("mv $col_inf $upper_path/fail/");
	}   
	return(-1,"fail\n");
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
#
###############################################################

sub Format_HashStruc {
        my ($pkg,$hash_ref) = @_;
        my $hash;

        if(exists $hash_ref->{'id'}){
		my $value = $hash_ref->{'id'};
                $hash={"$value"=>$hash_ref};
                delete $hash_ref->{'id'};
        }
        else{
                if(exists $hash_ref->{'name'}){
			my $value = $hash_ref->{'name'};
                        $hash={"$value"=>$hash_ref};
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

sub close {
        my ($pkg) = @_;

        undef($pkg);
        return($pkg);
}

1;
