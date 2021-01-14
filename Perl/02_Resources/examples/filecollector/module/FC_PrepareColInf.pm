package FC_PrepareColInf;

###############################################################################
#
#  @(#) Perl Module:FC_PrepareColInf
#  
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JIA XL 
#
#  Creation Date: 2002/12/15
#
#  Last update Date: 2003/02/24
#
#  Description:
#
###############################################################################

use Env qw(LDAP_MD_BASE NPM_HOME);

use XML::Simple;
use Data::Dumper;

use lib "$NPM_HOME/common/modules";

use LDAP_API;
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
	my ($type,$omc_id,$ne_type,$ne_int_id,$p_filename,$task_id) = @_;
    	my $self={};
    	$self->{'omc_id'}=$omc_id;
    	$self->{'ne_type'}=$ne_type;
    	$self->{'ne_list'}=$ne_int_id;
    	$self->{'p_filename'}=$p_filename;
	$self->{'task_id'}=$task_id;
    	bless $self,$type;
}

##############################################################
#
#  Function: create_col_inf
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

sub create_col_inf{
	my $self = shift;
	my $omc_id = $self->{'omc_id'};
	my $ne_type = $self->{'ne_type'};
	my $ne_list = $self->{'ne_list'};
	my $pcol_infcfg = $self->{'p_filename'};
	my $task_id = $self->{'task_id'};

	my ($omc_inf_ref,$childne_inf_ref);

	#-----------------------------------
        # Get OMC & Child_Ne information from LDAP server
        #-----------------------------------
	DBIs::Trace("Write to Colinf_Configfile ... \n");
	DBIs::Trace("Get information from LDAP Server ... \n");
    	my $ldap_hdl = new LDAP_API();
	if (($omc_id) && ($ne_list)) {
		my $base_node = "ou=$omc_id,".$LDAP_MD_BASE;
		my @ne_list =  split/,/,$ne_list;
		foreach my $ne (@ne_list) {
			my $ne_hash_ref = $ldap_hdl->get_attr_by_DSN($ne,$base_node);
			foreach my $key (keys %$ne_hash_ref) {
				$childne_inf_ref->{$key} = $ne_hash_ref->{$key};
			}
		}
	}
	elsif (($omc_id) && ($ne_type)) {
		my $base_node = "ou=$omc_id,".$LDAP_MD_BASE;
		my @ne_type = split/,/,$ne_type;
		foreach my $type (@ne_type) {
			my $filter = "cook_obj_class=$type and omc_id=$omc_id";
			my $ne_hash_ref = $ldap_hdl->get_attr_by_Filter($filter,$base_node);
			foreach my $key (keys %$ne_hash_ref) {
				$childne_inf_ref->{$key} = $ne_hash_ref->{$key};
			}
		}
	}
	$omc_inf_ref = $ldap_hdl->get_attr_by_DSN($omc_id,$LDAP_MD_BASE);
	if ($omc_inf_ref == 0) {
		DBIs::Trace("Can't Find OMC: $omc_id in LDAP Server !!\n",1,1030212,$pkg->{'task_id'});
		exit(-1);
	}
	$ldap_hdl = $ldap_hdl->close();

	#print Dumper($omc_inf_ref);
	#print Dumper($childne_inf_ref);exit;
	DBIs::Trace("Get information from LDAP Successfully ... \n");

	#------------------------------------------------
	# Get Colinf_filename & vendor_module name from Pcol_infcfg
	#------------------------------------------------
	eval{XMLin($pcol_infcfg)};
	if ($@) {
		DBIs::Trace("Read config file $pcol_infcfg Error! Check XML expression!"." File: ".__FILE__." Line: ".__LINE__."\n",1,1030213,$pkg->{'task_id'});
		exit(-1);
	}
	my $pcolinf_ref = XMLin($pcol_infcfg);
	my $colinf_file = $pcolinf_ref->{'Prime_col_inf'}{'Colinf_Config_file'};
	my $curr_process_id = $$;
	$colinf_file =~ s/\[TASK_ID\]/${curr_process_id}_\[TASK_ID\]/;
	$colinf_file =~ s/\[TASK_ID\]/$task_id/;
	$colinf_file =~ s/\[NPM_HOME\]/$NPM_HOME/;
	DBIs::Trace("Col_inf_File: \n$colinf_file \n");

	#----------------------------------------------
	# if programe needs vendor fuctions, then...
	#----------------------------------------------
	if (exists $pcolinf_ref->{'Prime_col_inf'}{'Vendor_Write_ChildNE'}) {

		#---------------------------------------
        	# Create a handle of Vendor_Module
        	#---------------------------------------
		my $vendor_path = $pcolinf_ref->{'Prime_col_inf'}{'Vendor_path'};
		$vendor_path =~ s/\[NPM_HOME\]/$NPM_HOME/;
		my $vendor_module = $pcolinf_ref->{'Prime_col_inf'}{'Vendor_module'};
		DBIs::Trace("Vendor_path: $vendor_path \n");
		DBIs::Trace("Vendor_module: $vendor_module.pm \n");
		my $vendor_hdl;
		eval{
			push @INC,$vendor_path;
        		require "$vendor_module.pm";
			$vendor_hdl = $vendor_module->new();
        	};
        	if ($@) {
        		DBIs::Trace("Create objects of $vendor_module.pm fail:$@"." FILE: ".__FILE__." Line:".__LINE__."\n",1,1030214,$pkg->{'task_id'});
			exit(-1);
        	}
		#----------------------------------------
		# Get ne information from Vendors Function
		#----------------------------------------
		my $vendor_func = $pcolinf_ref->{'Prime_col_inf'}{'Vendor_Write_ChildNE'}{'Fuction_name'};
		my $return_code;
		($return_code,$omc_inf_ref,$childne_inf_ref) = $vendor_hdl->$vendor_func($omc_inf_ref,$childne_inf_ref);
		$vendor_hdl = $vendor_hdl->close();
		if ($return_code < 0) {
			DBIs::Trace("Vendor_Module: $vendor_module.pm FuncTion: $vendor_func Failed ."." FILE: ".__FILE__." Line: ".__LINE__."\n",1,1030214,$pkg->{'task_id'});
			exit(-1);
		}
		my $childne_tmp;
		if ($ne_list) {
			foreach my $childne (keys %$childne_inf_ref) {
				if ($ne_list =~ /$childne/i) {
					$childne_tmp->{$childne} = $childne_inf_ref->{$childne};
				}
			}
			undef($childne_inf_ref);
			$childne_inf_ref = eval(Dumper($childne_tmp));
		}
	}
	#print "$ne_list \n ";
	#print Dumper($omc_inf_ref),Dumper($childne_inf_ref);exit;
	#--------------------------------------------
	# Write 'Parent_Ne_Var' and 'Child_Ne_Var'
	#--------------------------------------------
	my $omc_var_ref = $pcolinf_ref->{'Prime_col_inf'}{'Parent_Ne_Var'};
	my $childne_var_ref = $pcolinf_ref->{'Prime_col_inf'}{'Child_Ne_Var'};

	$omc_var_ref = $self->WriteHash($omc_var_ref,$omc_inf_ref);
	$childne_var_ref = $self->WriteHash($childne_var_ref,$childne_inf_ref);
	#print Dumper($omc_var_ref);
	#print Dumper($childne_var_ref);

        #-----------------------------------
        # Write Col_inf config File
        #-----------------------------------
	($return_code,$colinf_file) = $self->WriteColinf_cfgfile($colinf_file,$pcol_infcfg,$omc_var_ref,$childne_var_ref,$task_id);
	if ($return_code != 1) {
		DBIs::Trace("Write Col_inf config file: $colinf_file Error\n"." File: ".__FILE__." Line: ".__LINE__."\n");
	}
	eval{XMLin($colinf_file)};
	if ($@) {
		DBIs::Trace("Col_inf Config file is ERROR for XMLin() !!!\n");
	}
	else {
		DBIs::Trace("Write to Colinf_Configfile Successfully , The next ...\n");
	}
    	return ($colinf_file); 
}
##############################################################
#
#  Function: WriteColinf_cfgfile
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

sub WriteColinf_cfgfile {
	my ($self,$colinf_file,$pcol_infcfg,$omc_var_ref,$childne_var_ref,$task_id) = @_;

	#----------------------------------------------------------
	# Write 'Parent_Ne_Var' and 'Child_Ne_Var' in Col_inf_cfg
	#----------------------------------------------------------
	my $PN_xmlstr = $self->ConvertHash2Xml($omc_var_ref,'Parent_Ne_Var');
	my $CN_xmlstr = $self->ConvertHash2Xml($childne_var_ref,'Child_Ne_Var');
	
	#-----------------------------------
	# Write Col_inf config file 
	#-----------------------------------
	open (READ,$pcol_infcfg) || die "Can't open file:$pcol_infcfg\n"."File: ".__FILE__."Line ".__LINE__."\n";
	open (WRITE,">$colinf_file") || die "Can't open file: $colinf_file\n"."File: ".__FILE__."\nLine ".__LINE__."\n";
	my $pcol_inf_lines;
	while (<READ>) {
		$pcol_inf_lines .= $_;
	};
	$pcol_inf_lines =~ /(.*)\<Parent_Ne_Var\>.*\<\/Child_Ne_Var\>(.*)/s;
	my $output_part_before = $1;
	my $output_part_after = $2;
	$output_part_before =~ s/\[TASK_ID\]/$task_id/;
	print WRITE $output_part_before;
	print WRITE $PN_xmlstr;
	print WRITE "\n\t".$CN_xmlstr;
	print WRITE $output_part_after;
	close (READ);
	close (WRITE);

	return (1,$colinf_file);
}

##############################################################
#
#  Function: WriteHash
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
##############################################################

sub WriteHash {
	my ($self,$tgt_hash,$src_hash) = @_;
	my $result_hash;
	foreach my $key (keys %$src_hash) {
		my $hash_tmp = $src_hash->{$key};
		foreach my $src_key (keys %$hash_tmp) {
			foreach my $tgt_key (keys %$tgt_hash) {
				if (lc($src_key) eq lc($tgt_key)) {
					$tgt_hash->{$tgt_key}=$hash_tmp->{$src_key}; 
				}
			}
		}
		$result_hash->{$key} = eval(Dumper($tgt_hash));
	}
	return ($result_hash);
}    

##############################################################
#
#  Function: ConvertHash2Xml
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

sub ConvertHash2Xml {
	my ($self,$hash_str,$xml_tag) = @_;
	my ($xml);
	foreach my $key (keys %$hash_str) {
		my $xml_line = "<$xml_tag id=\"$key\" ";
		my $hash_tmp = $hash_str->{$key};
		foreach my $step_key (keys %$hash_tmp) {
			my $values = $hash_tmp->{$step_key};
			if ($values =~ /HASH\(.*\)/) {
				$values = 'NULL';
			}
			$xml_line .= $step_key."=\"$values\" ";
		}
		chop($xml_line);
		$xml_line .= "/>";
		$xml .= $xml_line."\n\t";
	}
	return ($xml);
}

sub close {
        my ($pkg) = @_;

        undef($pkg);
        return($pkg);
}

1;
