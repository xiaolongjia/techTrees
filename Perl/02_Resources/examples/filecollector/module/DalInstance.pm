#-----------------------------------------------------------------------------#
package DalInstance;
#-----------------------------------------------------------------------------#
# RCS Status      : $Id: DalInstance.pm,v 1.01 2003-02-20 12:00:00$
# Author          : Jia XL
# Created On      : The Feb 20 16:00:00 2003
# Last Modified By: Jia XL
# Last Modified On: Tue Feb 25 18:00:00 2003
# Status          : Released
#-----------------------------------------------------------------------------#
use strict;
use DBI;
use Data::Dumper;

require Exporter;
use vars qw(@ISA @EXPORT);
@ISA = qw(Exporter);
@EXPORT = qw(get_instance_class gethostname getlogname);

## Instance class for GP-NPM program
my %INSTANCE_CLASS = (
	#------ level1 ---------
	host		=> 0,
	#------ level2 ---------
	invoker		=> 100,
	#------ level3 ---------
	checklink	=> 201,
	checkdata	=> 202,
	filecollector	=> 203,
	checksource	=> 204,
	parser		=> 205,
	checkdest	=> 206,
	odbccollector	=> 207,
	adaptor		=> 208,
	#------ level4 ---------
	file		=> 301,
	table		=> 302
);
##---------------------------------------------------------------------------##
##  Constructor for this package
##  DalInstance->new(DSN,USER=>DSN_USER,PASSWORD=>DSN_PASSWORD)
##
sub new
{
        my $self  = shift;
	my $class = ref($self) || $self;
        my $dsn   = shift;
        my %attr  = @_;

	if (!(defined($dsn)&&defined($attr{USER})&&defined($attr{PASSWORD})))
	{
		$@ = 'Usage:new($dsn,USER=>$dsn_user,PASSWORD=>$dsn_password)';
		return undef;
	}
        my $this = {
        	DSN		=> $dsn,
        	USER		=> $attr{USER},
        	PASSWORD	=> $attr{PASSWORD}
        };
        $this->{'dbh'} = undef;
        bless $this, $class;
        $this;
}
##---------------------------------------------------------------------------##
##  make a database connection
##  First it check if the level1_rdn (host) is in the database.then create it
##  if not.
##  no argument needed
##
sub open
{
	my $this = shift;
	my $dbh;
	if($dbh = DBI->connect($this->{DSN}, $this->{USER}, $this->{PASSWORD})){
		$this->{'dbh'} = $dbh;
	}
	else{
		$@ = "can't connect to data source $this->{DSN}\n";
		return undef;
	}
	my $rdn = gethostname();
	if (! $this->add($rdn,instance_class=>get_instance_class('host'),
		instance_name=>'host',status=>0))
	{
		return undef;
	}
	$this;
}
##---------------------------------------------------------------------------##
##  get instance_id from level rdn given
##  $instance_handle->get_instance_id(
##		level1_rdn=>$level1_rdn,
##		level2_rdn=>$level2_rdn...);
##
sub get_instance_id
{
	my $this = shift;
	my %rdn  = @_;

	my ($sth, $i, $where);
	my @array;

	foreach my $level_dn (sort(keys(%rdn)))
	{
		if ($rdn{$level_dn} =~ /^\s*$/)
		{
			$where .= " AND $level_dn IS NULL";
		}
		else
		{
			$where .= " AND $level_dn = '$rdn{$level_dn}'";
		}
	}
	$where =~ s/^\s*AND\s*//;

	my $select_stmt ="SELECT instance_id FROM dal_instance WHERE $where";

	if(defined $this->{'dbh'}){
		if (!($sth = $this->{'dbh'}->prepare($select_stmt)))
		{
			$@ = "can not prepare $select_stmt:\n$DBI::errstr";
			return undef;
		}
		if (!($sth->execute))
		{
			$@ = "executr error $select_stmt:\n$DBI::errstr";
			return undef;
		}
		@array = $sth->fetchrow_array;
		if($sth->err){
			$@ = "fetch row error: $DBI::errstr";
			$sth->finish;
			return undef;
		}
		elsif(@array == 0){    # empty list
			$sth->finish;
			return undef;
		}
		$sth->finish;
		return $array[0];
	}
	else{
		$@ = "no dbh defined\n";
		return undef;
	}
}
##---------------------------------------------------------------------------##
##  add a new instance into database
##  $instance_handle->add($RDN,attrib_name=>value...)
##  $RDN formed by each level_rdn joined with "/"
##  return instance_id after insert
##
sub add
{
	my $this = shift;
	my $dn   = shift;
	my %attr = @_;

	my ($field,$value,$rdn_field,$rdn_value);
	my (@level_rdn, @parent_rdn);
	my ($sth, $instance_id, $parent_insid, $host, $username, $level);

	foreach my $column (keys(%attr))
	{
		$field .= "$column,";
		$value .= "'$attr{$column}',";
	}

	if(!defined($this->{'dbh'})){
		$@ = "Database not open yet";
		return undef;
	}

	@level_rdn = split(/\//, $dn);
	$instance_id = $this->get_instance_id(
		level1_rdn=>$level_rdn[0],
		level2_rdn=>$level_rdn[1],
		level3_rdn=>$level_rdn[2],
		level4_rdn=>$level_rdn[3]
	);
	return $instance_id if ($instance_id);
	@parent_rdn = split(/\//, $dn);
	$level = @level_rdn;
	for (my $i=1;$i<=@level_rdn;$i++)
	{
		$rdn_field .= "level${i}_rdn,";
		$rdn_value .= "'$level_rdn[$i-1]',";
	}

	if($level == 1){	# It means it is a root rdn
		$parent_insid = 0;
	}
	else{
		$parent_rdn[$level-1] = undef;
		$parent_insid = $this->get_instance_id(
			level1_rdn=>$parent_rdn[0],
			level2_rdn=>$parent_rdn[1],
			level3_rdn=>$parent_rdn[2],
			level4_rdn=>$parent_rdn[3]
		);
		if (! $parent_insid)
		{
			$@ = "can not find parent_instance_id of $dn";
			return undef;
		}
	}
	my $timestamp = _current();
	my $host = gethostname();
	my $user = getlogname();

	$field .= $rdn_field."init_time,last_updtime,parent_instance_id,username,host";
	$value .= $rdn_value."'$timestamp','$timestamp',$parent_insid,'$user','$host'";

	$this->{'dbh'}->do("set lock mode to wait 60");
	my $add_stmt = "INSERT into dal_instance ($field) VALUES ($value)";

	#print "$add_stmt\n";
	if(!($sth = $this->{'dbh'}->prepare($add_stmt))){
		$@ = "can not prepare statement $add_stmt:\nErr:$DBI::errstr";
		return undef;
	}
	if(!($sth->execute( ))){
		$@ = "can't execute statement $add_stmt:\n$DBI::errstr";
		return undef;
	}
	$sth->finish;
	$instance_id = $this->get_instance_id(
		level1_rdn=>$level_rdn[0],
		level2_rdn=>$level_rdn[1],
		level3_rdn=>$level_rdn[2],
		level4_rdn=>$level_rdn[3]
	);
	die $@ if ($@ && ! $instance_id);
	$instance_id;
}
sub delete
{
	my $this   = shift;
	my $ins_id = shift;
	my $sth;
	my $del_stmt = "set lock mode to wait 60;
		delete from dal_instance where instance_id=$ins_id or parent_instance_id=$ins_id";
	
	#print "$del_stmt\n";
	if (!($sth = $this->{'dbh'}->prepare($del_stmt)))
	{
		$@ = "can not prepare statement $del_stmt:\nErr:$DBI::errstr";
		return undef;
	}
	if(!($sth->execute( ))){
		$@ = "can't execute statement $del_stmt:\n$DBI::errstr";
		return undef;
	}
	$sth->finish;
	$this;
}
##---------------------------------------------------------------------------##
##  get a instance id of one task by the condition you specify.
##  $instance_handle->get_instance_id_by_task($task_id,column_name=>value...)
##
sub get_instance_id_by_task
{
	my $this = shift;
	my $task = shift;
	my %cond = @_;

	my $where = "task_id=$task";

	foreach my $column (keys(%cond))
	{
		$where .= " and $column='$cond{$column}'";
	}
	my $sel_stmnt = "SELECT instance_id FROM dal_instance WHERE $where";
	my ($sth, @array);
	if (!($sth = $this->{'dbh'}->prepare($sel_stmnt)))
	{
		$@ = "can not prepare statement $sel_stmnt:\nErr:$DBI::errstr";
		return undef;
	}
	if(!($sth->execute( ))){
		$@ = "can't execute statement $sel_stmnt:\n$DBI::errstr";
		return undef;
	}
	@array = $sth->fetchrow_array;
	if($sth->err)
	{
		$@ = "fetch row error: $DBI::errstr";
		$sth->finish;
		return undef;
	}
	$sth->finish;
	$array[0];
}
##---------------------------------------------------------------------------##
##  update a instance in database.also will update last_updtime automatically.
##  so you need not to update it use this method.there is tag $endtag to mark
##  if program is end.if it set TRUE,it will also update end_time
##  $instance_handle->update($instance_id,$endtag,attrib_name=>value...)
##
sub update
{
	my $this	= shift;
	my $instance_id = shift;
	my $endtag	= shift;
	my %attr	= @_;

	my $sth;
	my $set;

	if(!defined($this->{'dbh'})){
		$@ = "No Database handle found";
		return undef;
	}

	my $timestamp = _current();
	foreach my $colname (keys(%attr))
	{
		$set .= "$colname = '$attr{$colname}',"
	}
	$set .= "last_updtime='$timestamp'";
	$set .= ",end_time='$timestamp'" if ($endtag);

	$this->{'dbh'}->do("set lock mode to wait 60");
	my $upd_stmt ="UPDATE dal_instance SET $set WHERE  instance_id = $instance_id";
	#	print "$upd_stmt\n";

	if (!($sth = $this->{'dbh'}->prepare($upd_stmt)))
	{
		$@ = "can not prepare statement $upd_stmt:\n$DBI::errstr";
		return undef;
	}
	if(!$sth->execute){
		$@ = "can not execute $upd_stmt:\n$DBI::errstr";
		return undef;
	}
	$this;
}
##---------------------------------------------------------------------------##
##  get a temp table name generate by ODBC collector of one task
##  $instance_handle->get_tmptable_name($task_id,$meas_name)
##
sub get_tmptable_name
{
	my $this = shift;
	my $task_id = shift;
	my $meas_name = shift;

	my $hash = $this->get_tmptable_hash($task_id);
	if ((!$hash)&&$@)
	{
		die "$@\n";
	}
	$hash->{$meas_name};
}
##---------------------------------------------------------------------------##
##  get ALL temp table name generate by ODBC collector of one task into a hash
##  the hash's key is meas name,and value is temp table name
##  $instance_handle->get_tmptable_name($task_id,$meas_name)
##
sub get_tmptable_hash
{
	my $this = shift;
	my $task_id = shift;

	my $sth;
	my @array;
	my $hash;

	my $sel_stmt =<<"EOS";
SELECT name,level4_rdn
FROM   dal_instance
WHERE  task_id=$task_id
AND    instance_class=302
EOS
	if (!($sth = $this->{'dbh'}->prepare($sel_stmt)))
	{
		$@ = "can not prepare statement $sel_stmt:\n$DBI::errstr";
		return undef;
	}
	if(!$sth->execute){
		$@ = "can not execute $sel_stmt:\n$DBI::errstr";
		return undef;
	}
	while(@array = $sth->fetchrow_array)
	{
		$hash->{$array[0]} = $array[1];
		if($sth->err){
			$@ = "fetch row error: $DBI::errstr";
			$sth->finish;
			return undef;
		}
	}
	$sth->finish;
	$hash;
}
##---------------------------------------------------------------------------##
##  get rdn of one instance
##  $instance_handle->get_instance_rdn($instance_id)
##
sub get_instance_rdn
{
	my $this = shift;
	my $instance_id = shift;

	my $sth;
	my @array;
	my $rdn;

	my $sel_stmt =<<"EOS";
SELECT level1_rdn,level2_rdn,level3_rdn,level4_rdn,level5_rdn
FROM   dal_instance where instance_id=$instance_id
EOS
	if (!($sth = $this->{'dbh'}->prepare($sel_stmt)))
	{
		$@ = "can not prepare statement $sel_stmt:\n$DBI::errstr";
		return undef;
	}
	if(!$sth->execute){
		$@ = "can not execute $sel_stmt:\n$DBI::errstr";
		return undef;
	}
	@array = $sth->fetchrow_array;
	if($sth->err){
		$@ = "fetch row error: $DBI::errstr";
		$sth->finish;
		return undef;
	}
	$sth->finish;
	if (@array < 5)
	{
		$@ = "can not find rdn for $instance_id";
		return undef;
	}
	$rdn = join("/",@array);
	$rdn =~ s/\s*\/\s*/\//g;
	$rdn =~ s/[\s\/]+$//;
	$rdn;
}
##---------------------------------------------------------------------------##
##  generate rdn of one instance
##  $instance_handle->gen_self_rdn
##
sub gen_self_rdn
{
	my $this = shift;

	my $timestamp = _current();
	$timestamp."_$$";
}
##---------------------------------------------------------------------------##
##  Increase recollect times for a task
##
sub increase_times
{
	my $this = shift;
	my $task_id = shift;
	
	my $sth;
	
	my $upd_stmnt = "UPDATE dal_instance SET times=times+1 WHERE task_id=$task_id";
	if (!($sth = $this->{'dbh'}->prepare($upd_stmnt)))
	{
		$@ = "can not prepare statement $upd_stmnt:\n$DBI::errstr";
		return undef;
	}
	if(!$sth->execute){
		$@ = "can not execute $upd_stmnt:\n$DBI::errstr";
		return undef;
	}
	$sth->finish;
	$this;
}
	
##---------------------------------------------------------------------------##
##  get instance class of specified instance name,instance name is keys of
##  hash %INSTANCE_CLASS defined upon.
##
sub get_instance_class
{
	my $instance_name = shift;

	$INSTANCE_CLASS{$instance_name};
}
##---------------------------------------------------------------------------##
##  get host's name
##
sub gethostname
{
	my $name = `uname -n`;
	chomp $name;
	$name;
}
##---------------------------------------------------------------------------##
## get current user name
##
sub getlogname
{
	my $name = `logname`;
	chomp $name;
	$name;
}
##---------------------------------------------------------------------------##
## get command of current program
##
sub get_cmd_line
{
	my $argv = shift;
	my $cmd;
	foreach my $arg (@$argv)
	{
		if ($arg !~ /^-/)
		{
			$cmd .= " \"$arg\"";
		}
		else
		{
			$cmd .= " $arg";
		}
	}
	$cmd = $0." $cmd";
	$cmd;
}
##---------------------------------------------------------------------------##
## get command of current program
##
sub get_omclist_current_run
{
	my $this   = shift;
	my $omc_id =shift;
	
	my @array;
	my $sth;
	
	my $sel_stmt =<<"EOS";
SELECT count(*)  
FROM   dal_task a,dal_datacheck b 
WHERE  omc_id     = $omc_id
and    a.run_flag = 0
AND    a.check_id = b.check_id
EOS
	if (!($sth = $this->{'dbh'}->prepare($sel_stmt)))
	{
		$@ = "can not prepare statement $sel_stmt:\n$DBI::errstr";
		return undef;
	}
	if(!$sth->execute){
		$@ = "can not execute $sel_stmt:\n$DBI::errstr";
		return undef;
	}
	@array = $sth->fetchrow_array;
	if($sth->err){
		$@ = "fetch row error: $DBI::errstr";
		$sth->finish;
		return undef;
	}
	$sth->finish;
	$array[0];
}
##---------------------------------------------------------------------------##
## get current time
##
sub _current
{
	my $time = `date "+%Y-%m-%d %H:%M:%S"`;
	chomp $time;
	$time;
}
sub close
{
	my $this = shift;

	if(defined($this->{'dbh'})){
		$this->{'dbh'}->disconnect;
	}
}

1;
