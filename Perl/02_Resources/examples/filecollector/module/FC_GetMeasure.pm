package FC_GetMeasure;

###############################################################################
#
#  @(#) Perl Module: FC_GetMeasure
#
#  Author(s): JIA XL
#  
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Creation Date:  2002/12/16
#
#  Last update  Date: 2003/02/21
#
#  Description: This module get MeaSure info from df_configfile
#
#
##############################################################################

use XML::Simple;
use Data::Dumper;

#######################################################################
#
# Function: New
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub new {
	my ($type,$config_file,$table_name,$measure)=@_;
    	my $self={};
	$self->{'table'} = $table_name;
	$self->{'measure'} = $measure;
	$self->{'config_file'} = $config_file;
    	bless $self,$type;
}

#######################################################################
#
# Function: GetMeasure
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub GetMeasure {
	my ($self) = @_;
	my $table = $self->{'table'};
	my $measure = $self->{'measure'};
	my $df_cfg_file = $self->{'config_file'};
	my $config_ref = &prepare($df_cfg_file);
	if (!(exists $config_ref->{'Prime_col_inf'}{'Assistant_Var'})) {
                print "Notice: the Assistant_Var is not defined in config_file!\n\n";
		return(1);
        }
	my $Assistant_Var = $config_ref->{'Prime_col_inf'}{'Assistant_Var'};
	my $tbl_v2c;
	if ($table) {
		my @tbl_list = split /,/,$table;
		my $measure_part = $Assistant_Var->{'Measure_Var'}{'Measure'};
		foreach my $id (keys %$measure_part) {
			my $cfg_table_str = $measure_part->{$id}{'tbl_name'};
			my @cfg_table = split /,/,$cfg_table_str;
			foreach my $tbl_name (@tbl_list) {
				for (@cfg_table) {
					my $tab = $_;
					if ($tbl_name =~ /$tab/i) {
						my $v_body = $measure_part->{$id}{'body'};
						$tbl_v2c->{$v_body} = $tbl_name;
					}
				}
			}
		}
	}
	elsif ($measure){
		my @mea_list = split /,/,$measure;
		my $measure_part = $Assistant_Var->{'Measure_Var'}{'Measure'};
		foreach my $id (keys %$measure_part) {
			foreach my $measure_name (@mea_list) {
				if (lc($measure_name) eq lc($measure_part->{$id}{'body'})) {
					$tbl_v2c->{$measure_name} = $measure_part->{$id}{'tbl_name'};
				}
			}
		}
	}
	else {
		my $measure_part = $Assistant_Var->{'Measure_Var'}{'Measure'};
		foreach my $id (keys %$measure_part) {
			my $tbl_name = $measure_part->{$id}{'tbl_name'};
			my $tbl_body = $measure_part->{$id}{'body'};
			$tbl_v2c->{$tbl_body} = $tbl_name;
		}
	}
	delete $Assistant_Var->{'Measure_Var'}{'Measure'};
	$Assistant_Var->{'Measure_Var'}{'Measure'} = $tbl_v2c;

	return ($Assistant_Var);
}

#######################################################################
#
# Function: Prepare
#
# Input: null
#
# Output: 1. singal
#         2. message
#
# Description:
#
#######################################################################

sub prepare{
	my ($config_file) = @_;
    	my $config_ref = eval{XMLin($config_file)};
    	if ($@){
		print "Read file $config_file failed.\n $@";
		return (-1);
    	}
	$config_ref = &simple_TransformHash($config_ref,'id');
    	return ($config_ref);
}

########################################################################
#
#   Function :simple_TransformHash
#
#   Input:  $ddd_ref:ref to hash_struct
#           $key: the key when transforming
#
#   Return: ref to hash_struct which is transformed
#
#
#######################################################################

sub simple_TransformHash{
	my ($ddd_ref,$key)=@_;
    	foreach $hash_key(keys %$ddd_ref){
        	if (exists($ddd_ref->{$hash_key}->{$key})){
       	  		my $tmp_hash=$ddd_ref->{$hash_key};
         		my $tmp_id=$ddd_ref->{$hash_key}->{$key};
         		delete $$tmp_hash{$key};
         		my %add_hash=($tmp_id=>$tmp_hash);
         		$ddd_ref->{$hash_key}=\%add_hash;
         	}
	}
    	foreach $hash_value(values %$ddd_ref){
         	&simple_TransformHash($hash_value,$key);
    	}
    	return $ddd_ref;
}

sub close {
	my ($pkg) = @_;

	undef($pkg);
	return($pkg);
}

1;
