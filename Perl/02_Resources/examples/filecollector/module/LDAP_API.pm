package LDAP_API;

###############################################################################
#
#  @(#) Perl Module:  LDAP_API
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JiaXiaoLong
#
#  Creation Date: 2003-02-22
#
#  Description: This is a perl library for get cofigure from ldap server (Sun Solaris 2.x)
#
#  LDAP TREE:
#	o=boco
#	   |_ou=ini
#		|__ou=NPM
#			|__ou=MD
#			      |__ou=001
#		|__ou=dsn
#			|__ou=coodkb2
#			|__ou=401
#		|__ou=MQ
#			|__ou=dc.q
#
#	$LDAP_NPM_BASE	="ou=NPM,ou=ini,o=boco"
#	$LDAP_SERVER	="10.0.190.200"
#
###############################################################################

use Data::Dumper;
use Net::LDAP;
use Net::LDAP::LDIF;

use Env qw(LDAP_SERVER LDAP_NPM_BASE LDAP_MD_BASE LDAP_DSN_BASE);

#######################################################################
#
# Function: New
#
# Input: no
#
# Output:  a handle of LDAP_API 
#
# Description: Create a object to LDAP_API.pm
#
#######################################################################

sub new {
	my ($pkg,$ip,$dn,$pwd) = @_;
        my $self={};
	$self->{'ldap_hdl'} = $pkg->Bind2LDAP($ip,$dn,$pwd);
        bless $self,$pkg;
        return undef if(!defined($self->{'ldap_hdl'}));
        $self;
}

#######################################################################
#
# Function: Bind2LDAP
#
# Input: no
#
# Output:  
#
# Description: Bind to LDAP Server
#
#######################################################################

sub Bind2LDAP {
	my ($pkg,$ip,$dn,$pwd) = @_;
	my $ldap_hdl;
	my $lrt;
	if(!defined($ip) and defined($LDAP_SERVER))
	{
		$ip = $LDAP_SERVER;
	}
	$ldap_hdl = Net::LDAP->new("$ip") or return undef;
	if(!defined($dn))
	{
		$lrt = $ldap_hdl->bind() or return undef;
	}
	else
	{
		$lrt = $ldap_hdl->bind(dn=>"$dn",password=>"$pwd") or return undef;
	}
	defined($lrt) || die "Err: LDAP bind fail !!!\n";
	$lrt->code && die "code error!!!\n";

	return($ldap_hdl);
}

#######################################################################
#
# Function: get_md_attr
#
# Input: no
#
# Output: md attribute
#
# Description: 
#
#######################################################################

sub get_md_attr {
	my ($pkg) = @_;
	my $ldap_hdl = $pkg->{'ldap_hdl'};
	
	my @ou_list = split /,/,$LDAP_MD_BASE;
	$ou_list[0] =~ /(\w+)=(\w+)/;
	my $md_attr_hash = $pkg->get_attr_by_DSN("$2",$LDAP_NPM_BASE);
	$md_attr_hash = $md_attr_hash->{$2};
	
	return ($md_attr_hash);
}

#######################################################################
#
# Function: get_mddb_attr
#
# Input: no
#
# Output: md attribute
#
# Description:
#
#######################################################################

sub get_mddb_attr {
	my ($pkg) = @_;

	my $md_attr = $pkg->get_md_attr();
	my $mddb_dsn = $md_attr->{'mddb_dsn'};
	my $mddb_hash = $pkg->get_attr_by_DSN("mddb");
	my $mddb_attr_hash = $mddb_hash->{$mddb_dsn};

	return ($mddb_attr_hash);
}

#######################################################################
#
# Function: get_attr_by_DSN
#
# Input: $dsn , $base_node
#
# Output: all attributes of $dsn_name  ( a hash_ref )
#
# Description: 
#
#######################################################################

sub get_attr_by_DSN {
	my ($pkg,$dsn,$base_node) = @_;

	if (!$base_node) {
		$base_node = $LDAP_DSN_BASE;
	};

	my @dsn = split /,/,$dsn;
	my $hash_ref;

	foreach my $dsn_name (@dsn) {
		#print "Now Search DSN: \nou= $dsn_name \nbase_node= $base_node ...\n\n";
		my $ldap_hdl = $pkg->{'ldap_hdl'};
		my $lrt = $ldap_hdl->search(
               		base    => $base_node,
               		scope   => "sub",
               		filter  => "(ou=$dsn_name)"
        	);
		defined($lrt) or die "Search $dsn_name fail !!\nPlease Chick it\n";
		$lrt->code && next;
		
		my $entry = $lrt->entry(0);
		if(!(defined $entry)) {
#			print "Not Find NE ... \n\n";
			return(0);
		}
		foreach my $attr ($entry->attributes) {
			#print $attr."\t\t\t".$entry->get_value($attr)."\n\n";
                	$hash_ref->{$dsn_name}->{$attr} = $entry->get_value($attr);
		}
        }
	if(!$hash_ref) {
#		print "Not Find NE ... \n\n";
	}
	return($hash_ref);
}

#######################################################################
#
# Function: get_attr_by_Filter
#
# Input: $dsn_filter , $base_node
#
# Output: all attributes of all DSN
#
# Description: 
#	$dsn_filter like "cookdb_obj_class=101 and related_ou=601" or "cookdb_obj_class=101 or related_ou=601" , But not "cookdb_obj_class=101 and related_ou=601 or atop_user=wnms#1".
#	Filter rule: and="&" , or="||" 
#
#######################################################################

sub get_attr_by_Filter {
	my ($pkg,$dsn_filter,$base_node) = @_;

	if (!$dsn_filter) {
		return (1);
	}
	if (!$base_node) {
                $base_node = $LDAP_DSN_BASE;
        };

	my $filters='';
	if ($dsn_filter =~ /\band\b/) {
		my @dsn_filter = split /and/,$dsn_filter;
		for (my $i=0;$i<@dsn_filter;$i++) {
			$dsn_filter[$i] =~ s/\s*//g;
			if ($i==@dsn_filter-1) {
				$filters .= "(".$dsn_filter[$i].")";
			}else {
				$filters .= "&(".$dsn_filter[$i].") ";
			}
		}
	}
	elsif ($dsn_filter =~ /\bor\b/) {
                my @dsn_filter = split /or/,$dsn_filter;
                for (my $i=0;$i<@dsn_filter;$i++) {
                        $dsn_filter[$i] =~ s/\s*//g;
                        if ($i==@dsn_filter-1) {
                                $filters .= "(".$dsn_filter[$i].")";
                        }else {
                                $filters .= "|(".$dsn_filter[$i].") ";
                        }
                }
        }
	else {
		$filters = $dsn_filter;
	}
        #print "\nNow Search DSN: \nFilter= $filters \nbase_node= $base_node ...\n\n";

        my $ldap_hdl = $pkg->{'ldap_hdl'};

        my $lrt = $ldap_hdl->search(
        	base    => $base_node,
        	scope   => "sub",
        	filter  => "$filters"
        );

        defined($lrt) or die "Search failed !!\nPlease Chick it\n";
        $lrt->code && die "Search DSN fail !!\n\n";

	my $hash_ref;
        my $entries = $lrt->{'entries'};
	if (!(defined $entries)) {
		print "Not Find NE ... \n\n";
		return(0);	
	}
	foreach my $entry (@$entries) {
		my ($ou_tmp,$hash_tmp);
        	foreach my $attr ($entry->attributes) {
        		#print $attr."\t\t\t".$entry->get_value($attr)."\n";
			if ($attr =~ /^ou$/) {
				$ou_tmp = $entry->get_value($attr);
			}
               		$hash_tmp->{$attr} = $entry->get_value($attr);
        	}
		$hash_ref->{$ou_tmp} = $hash_tmp;
	}

	if(!$hash_ref) {
		print "Not Find NE ... \n\n";
        }
	return ($hash_ref);
}

sub close {
	my ($pkg) = @_;
	my $ldap = $pkg->{'ldap_hdl'};
	$ldap->unbind;
	undef($pkg);
	return($pkg);
}
#======================================================================================================
# Function name	: add_entry
# Description	: add an entry to LDAP
# Input		: $entry_name
#		  $base_node
#		  %attr_hash	
# Return	: 0 : Fail
#		  1 : Success
# Latest Update	: 2003-03-21 10:00
#======================================================================================================
sub add_entry
{
	my ($this,$entry_name,$base_node,%attr_hash) = @_;
	my $ldap	= $this->{'ldap_hdl'};
	my $rc;
	$entry_name	= $entry_name.",".$base_node;
	$rc = $ldap->add(
			$entry_name,
		   	attr=>
			[
			'objectclass'=>'top',
			%attr_hash
			])|| warn "failed to add entry : $!"; 
	return 0 if !$rc;
	return 1;
}
#======================================================================================================
# Function name	: delete_entry
# Description	: delete an entry of LDAP
# Input		: $entry_name
#		  $base_node
# Return	: 0 : Fail
#		  1 : Success
# Latest Update	: 2003-03-21 10:00
#======================================================================================================
sub delete_entry
{
	my ($this,$entry_name,$base_node) = @_;
	my $ldap	= $this->{'ldap_hdl'};
	my $rc;
	$entry_name	= $entry_name.",".$base_node;
	$rc = $ldap->delete ($entry_name) || warn "failed to delete entry : $!"; 
	return 0 if !$rc;
	return 1;
}
#======================================================================================================
# Function name	: modify_attr
# Description	: modify attributes of specified entry
# Input		: $entry_name
#		  $base_node
#		  %attr_hash	
# Return	: 0 : Fail
#		  1 : Success
# Latest Update	: 2003-03-21 10:00
#======================================================================================================
sub modify_attr
{
	my ($this,$entry_name,$base_node,%attr_hash) = @_;
	my @attr_array	= keys(%attr_hash);
	my $ldap	= $this->{'ldap_hdl'};
	my $rc;
	$entry_name	= $entry_name.",".$base_node;
	$rc = $ldap->modify(	$entry_name,
				replace=>{%attr_hash}
			    )|| warn "failed to modify attribute : $!";
	return 0 if !$rc;
	return 1;
}
#======================================================================================================
# Function name	: add_attr
# Description	: add attributes to specified entry
# Input		: $entry_name
#		  $base_node
#		  %attr_hash	
# Return	: 0 : Fail
#		  1 : Success
# Latest Update	: 2003-03-21 10:00
#======================================================================================================
sub add_attr
{
	my ($this,$entry_name,$base_node,%attr_hash) = @_;
	my @attr_array	= keys(%attr_hash);
	my $ldap	= $this->{'ldap_hdl'};
	my $rc;
	$entry_name	= $entry_name.",".$base_node;
	$rc = $ldap->modify($entry_name,
			    add=>{%attr_hash}
			   )|| warn "failed to add attribute : $!";
	return 0 if !$rc;
	return 1;
}
#======================================================================================================
# Function name	: delete_attr
# Description	: delete attributes from specified entry
# Input		: $entry_name
#		  $base_node
#		  @attr_array
# Return	: 0 : Fail
#		  1 : Success
# Latest Update	: 2003-03-21 10:00
#======================================================================================================
sub delete_attr
{
	my ($this,$entry_name,$base_node,@attr_array) = @_;
	my $ldap	= $this->{'ldap_hdl'};
	my $rc;
	$entry_name	= $entry_name.",".$base_node;
	$rc = $ldap->modify(
				$entry_name,
				delete=>[@attr_array]
			   )|| warn "failed to add attribute : $!";
	return 0 if !$rc;
	return 1;
}

1;
