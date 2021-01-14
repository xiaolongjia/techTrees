package DBIs;
my $DBIs_VERSION 	= "DBIs v2.0.0.021206(Released)";
my $MPL_VERSION		= "MPL  v2.0.0.0000(Released)";
my $MAP_VERSION		= "MAP  v2.0.0.0000(Released)";
#----------------------------------------------------------------------------
# @(#) Perl Module: DBIs
# Copyright(C) 2001-2005 BOCO Inter-Telecom, All Rights Reserved
#
# Description: This perl program includes Data Collector subroutines.                                                       
# DREATED BY:  Jia XL                                                  
# MODIFY TIME: 2003-03-03 22:00:00
# CREAYEDTIME: 2001-07-02                        
#----------------------------------------------------------------------------
# Subroutines:
#----------------------------------------------------------------------------
# Set_DataCheck
# Write_Dchk_Err
# Set_PwdEncrypt
# Set_WriteOlog
# Set_MsgSend
# Set_MSName
# Set_MQName
# Set_BcpMode
# Set_BcpWnmsDatabase
# Set_NoBcp
# Set_Debug
# Sort_By_Number
# Set_Database_Type
# Set_OSSDB_Type
# Init_Qetxt_Files
# GenerateKey
# Encode
# Pwd_Encrypt
# Decode
# Pwd_Decrypt
# Trim
# DFtime
# GMtime
# FMtime
# CFtime
# Set_Trace_Modes
# Set_Mpl_Version
# Init_Trace
# Trace
# End_Trace
# Connect_DB
# Disonnect_DB
# Commit_DB
# Rollback_DB
# Exec_Sql
# Set_Isdirty_Read
# Find_Bcp_Oldtab
# Bcp
# Exec_Finish
# OnError
# SetError
# Write_OlogDB
# Create_Tmptable_Name
# Get_Column_List
# Debug
# Get_DBMS
# Set_DBMS
# Get_ODBMS
# Set_ODBMS
# Get_DBMS_From_File
# Get_ObjClass_by_NeName
# Read_IniFile
# Init_Variable
# Read_MapIniFile
# Hex2spc
# Int2spc
# Bin2spc
# Int2bin
# Hex2bin
# Bin2int
# Int2hex
# Hex2int
# Sql_Info
# Tab_Info
# Replace_SQL_Standard_Type
# Replace_SQL_Standard2Database_Type
# Net_Ftp_Connect
# Net_Ftp_Disconnect
# Net_Ftp_Get
# Net_Ftp_Put
# Net_Telnet_Connect
# Net_Telnet_Disconnect
# Net_Telnet_Cmd
# Touch_Dir
# Send_Msg
# MQSend
# MQReceive
# FmtMsg
#-----------------------------------------------------------------------
#Modified 2002-04-11(v2.0.0410.01):
#	1.Bcp change to use bind.
#Modified 2002-04-24(v2.0.0410.02):
#	1.And function Int2bin
#Modified 2002-04-27(v2.0.0410.03):
#	1.And Debug of Set_DBMS Trace
#Modified v2.0.0430:
#	1.modify verion of mpl,DBIs and map.
#Modified v2.0.0505:
#	1.add FMtime.
#	2.and GMtime.
#Modified v2.0.0506:
#	1.add Pwd_Encrypt.
#	2.and Pwd_Decrypt.
#	3.and Int2hex.
#	4.pwd encrypt.
#Modified v2.0.0507:
#	1.add DFtime.
#Modified v2.0.0508:
#	1.TempTable add process id.
#Modified v2.0.0516:
#	1.Connect_DB with parameter auto commit.
#Modified v2.0.0518:
#	1.Add Sql Standard type support.
#	2.Add Replace_SQL_Standard_Type().
#	3.Modify Exec_sql() sql statement with Replace_SQL_Standard_Type;
#Modified v2.0.0524:
#	1.use strict
#	2.and Net:FTP
#	2.and Net:TELNET
#Modified v2.0.0601:
#	1.Bcp add print standant type
#	2.oracle number type suport
#Modified v2.0.0.602:
#	1.Pwd encrypt/decrypt update.
#Modified v2.0.0.604:
#	1.Add MQsend/MQreceive
#Modified v2.0.0.609:
#	1.Bcp with buffer flag
#Modified v2.0.0.620:
#	1.Bcp Data type sql_varchar 255 limited
#Modified v2.0.0.0704:
#	1.fix the bug of Bcp Data type SQL_NUMBER(type =2) is float or integer
#Modified v2.0.0.0709:
#	1.add v2.1 msg ctrl
#	2.fix the bug of debug info wrong.
#Modified v2.0.0.0712:
#	1.insert tad_instance_err
#Modified v2.0.0.0715:
#	1.fix the bug of Bcp prepare twice.
#       2.Bcp with counter statement if select sql statement
#	3.Bcp with commit each 1000 rows if oracle database
#	4.BcpBuffer delfault 0
#	5.Msg body add '<![CDATA[string value]]>'
#Modified v2.0.0.0719:
#	1.fix the bug of bcp counter error because of group/order/having
#Modified v2.0.0.0722:
#	1.add bcp mode load but it can not use.
#	2.add attribute set isolation dirty to read
#Modified v2.0.0.0724:
#	1.Bcp add serial id.
#	2.change bcp counter use fetchrow all.
#	3.list all sub function
#Modified v2.0.0.0801:
#	1.modify Set_Isdirty_Read and db_type par.
#	2.Modify Bcp Set_Isdirty_Read
#	3.add Set_OSSDB_Type
#Modified v2.0.0.0814:
#	1.fix the bug of sql type -1 longvarchar without length limited
#Modified v2.0.0.0816:
#	1.Add Bcp dbload(informix)
#Modified v2.0.0.0817:
#	1.Add BcpMode set function
#	2.Add BcpMode from local database
#Modified v2.0.0.0819:
#	1.fix the bug of Bcp with bind because of id not add.
#	2.Modify all trace mode.
#Modified v2.0.0.0820:
#	1.Add set lock mode to wait.
#Modified v2.0.0.0823:
#	1.Modify bcp error ignore it.
#Modified v2.0.0.0904:
#	1.Modify create temptable TMP + Mhhmmss + 2 bit proc id + 3 bit serial
#	2.fix the bug of CFTime D => 'D '.
#Modified v2.0.0.1014:
#	1.add code in OnError for locating error
#	2.log file copied to $DAL_HOME/trace/ERROR_LOG when any errors occur
#Modified v2.0.0.021126:
#	1.Modify Bcp function return bcp num
#Modified v2.0.0.021205:
#	1.Add data collect check error.func:Set_DataCheck,Write_Dchk_Err
#Modified v2.0.0.021206:
#	1.Modified msg format for TManager Tools
#----------------------------------------------------------------------------
# Modified for GP-NPM projects By Zhang Jingjing
# Last Update : 2003-03-05
# 
# New Variable: 
#		$CONFIG_IN_LDAP;
#		$MESSAGE_QUEUE_ID;
#		$TPM_TABLE_NAME;
#		$DAL_LOG_HASH;
#		$MDDB_DSN;
# New Function: 
#		NPM_Set_LDAP_Flag
#		NPM_Set_MSGQueue_ID
#		NPM_Set_TPMTable_Name
#		NPM_Get_DBMS_From_LDAP
#		NPM_Send_Message
#		NPM_Write_DalLog
#		NPM_Set_DalLog
#		NPM_Set_MDDB_DSN
#		NPM_Bak_Insert
#		NPM_Bak_Bcp
# Modified Function: 
# Add code block to send message to message queue specified by $MESSAGE_QUEUE_ID
# and calling of NPM_Write_DalLog
#		Set_DBMS
#		Exec_Sql
#		Connect_DB
#		Disonnect_DB
#		Commit_DB
#		OnError
#		Bcp
#----------------------------------------------------------------------------
use Env 	qw(HOME);
use Env 	qw(DAL_HOME);
use Env 	qw(INFORMIXDIR);
use lib 	"$DAL_HOME/NPM/common/modules";
use DBI;
use IO;
use Time::Local;
use Net::FTP;
use Net::Telnet;
use FileHandle;
#use BocoMQ;
use LDAP_API;
use Data::Dumper;
#use XML::Simple;
#use strict;

if (!$DAL_HOME)
{
	$DAL_HOME = $HOME;
}

#Global variables
my $PROG_NAME;
my $OMC_ID;
my $PM_DCHK = 0;
my $PM_DCHK_STIME;
my $PM_DCHK_ETIME;
my $PM_DCHK_PNAME;
my $COOKDB_TYPE = "INFORMIX";
my $OSSDB_TYPE  = "UNKNOWN";
my $SQL_TYPE_INFO;
my ($conn_dbn,$conn_dbd,$conn_uid,$conn_pwd,$conn_mark,$net_telnet);
my ($olog_dbd,$olog_dbn,$olog_uid,$olog_pwd,$net_ftp);
my $MapiFile 		= $DAL_HOME."/.mapi.ini";
my $Lock2WaitSec	= 60;
my $TraceFileName 	= "";
my $RepFileName 	= "";
my $TraceModes 		= "SRC";
my $TmpTabTimes 	= 0;
my $DeBug		= 0;
my $PwdEncrypt		= 0;
my $BcpBuffer		= 0;
my $BcpMode		= 1;			#0: SQL Statement  1: Bind  
						#2: Load(dbaccess load for informix/sqlload for oracle)
						#3: Dabase Link (from local db to local db)
my $Wnms_Database	= 'mddb';		#$BcpMode = 2 then use it
my $Data_Load_TmpDir	= '';			#$BcpMode = 2 then use it
my $Del_Bcpfile		= 1;			#$BcpMode = 2 then use it

my $Bcptab_Serial	= 0;			#Bcp Table Counter
my $Use_Bcp_Oldtab	= 0;			#0: Not use  1: Use
my $Bcp_Oldtab_Logfile;				#When use bcp old tab,use The log information
my $ErrorRollBack 	= 1;
my $ErrorCommit 	= 0;
my $ErrorExit 		= 1;
my $ErrorDebug 		= 0;
my $NetTimeout		= 60*30;
my @char2hextab 	= ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9","A", "B", "C", "D", "E", "F");
my $net_prompt 		= '_funkyPrompt_';
my $prekey 		= "!#&<>_|~";

#-------------------------------------------------------------------------------
my $CONFIG_IN_LDAP	= 0;
my $NPM_WriteDaLlog_mod	= 1;
my $MESSAGE_QUEUE_ID;
my $TPM_TABLE_NAME;
my $DAL_LOG_HASH;
my $MDDB_DSN;
my $Message_Text;
my $NPM_MESSAGE		=
{
	200     => "Unit NOT found in LDAP",
        201     => "Incorrect database connection information",
        202     => "Can not connect database",
        203     => "Failed when write trace file",
        204     => "Failed when create trace directory",
        210     => "Error when SQL statement prepare",
        211     => "Error when SQL pararmeter bind",
        212     => "Error when SQL executed",
        250	=> "Error when SQL do"
};
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
my $WriteOlog		= 0;
my $MsgSend		= 0;
my $MSName		= "DEFAULT_QM";
my $MQName		= "CTRL.Q";
my $DMMMT_DCMSG;
my $DMMMT_DCMSG_TASK_ID	= 1;
my $DMMMT_DCMSG_INSTANCE_ID;
my $DMMMT_DCMSG_INSTANCE_RDN;
my $DMMMT_DCMSG_INSTANCE_START;
my $DMMMT_DCMSG_TIMESTAMP;
my $DMMMT_DCMSG_TYPE		= 1280;		#_T("DC的消息")
my $DMMMT_DCMSG_ST_INSSTART 	= 1; 		#Instance start
my $DMMMT_DCMSG_ST_INSSTOP  	= 2; 		#Instance stoped
my $DMMMT_DCMSG_ST_INSERROR 	= 3; 		#running error
my $DMMMT_DCMSG_ST_INSINFO  	= 4; 		#running information
#-------------------------------------------------------------------------------

#Cookdb object class
my %COOKDB_OBJECT_CLASS;
$COOKDB_OBJECT_CLASS{"PLMN"}		= 0	;
$COOKDB_OBJECT_CLASS{"ME"}		= 10	;
$COOKDB_OBJECT_CLASS{"OMC"}		= 100	;
$COOKDB_OBJECT_CLASS{"MSC"}		= 101	;
$COOKDB_OBJECT_CLASS{"HLR"}		= 102	;
$COOKDB_OBJECT_CLASS{"AUC"}		= 104	;
$COOKDB_OBJECT_CLASS{"EIR"}		= 106	;
$COOKDB_OBJECT_CLASS{"BSS"}		= 107	;
$COOKDB_OBJECT_CLASS{"BSC"}		= 200	;
$COOKDB_OBJECT_CLASS{"SITE"}		= 201	;
$COOKDB_OBJECT_CLASS{"TG"}		= 301	;
$COOKDB_OBJECT_CLASS{"BTS"}		= 300	;
$COOKDB_OBJECT_CLASS{"TRX"}		= 400	;
$COOKDB_OBJECT_CLASS{"CHANNEL"}		= 402	;
$COOKDB_OBJECT_CLASS{"RADIO"}		= 403	;
$COOKDB_OBJECT_CLASS{"ADJCELLHO"}	= 406	;
$COOKDB_OBJECT_CLASS{"ADJCELLREL"}	= 407	;
$COOKDB_OBJECT_CLASS{"TRUNKGROUP"}	= 600	;
$COOKDB_OBJECT_CLASS{"LINKSET"}		= 602	;

my %SQL_TYPE_INFORMIX;
%SQL_TYPE_INFORMIX = (
	1	=>"CHAR",
	2	=>"INTEGER",
	3	=>"DECIMAL",
	4	=>"INTEGER",
	5	=>"SMALLINT",
	6	=>"FLOAT",
	7	=>"SMALLFLOAT",
	8	=>"FLOAT",
	9	=>"DATE",
	10	=>"DATETIME HOUR TO SECOND",
	11	=>"DATETIME YEAR TO SECOND",
	93	=>"DATETIME YEAR TO SECOND",
	12	=>"VARCHAR",
	-1	=>"VARCHAR",
	-2	=>"SMALLINT",
	-3	=>"SMALLINT",
	-4	=>"INTEGER",
	-5	=>"SMALLINT",
	-6	=>"SMALLINT",
	-7	=>"SMALLINT",
	-8	=>"CHAR",
	-9	=>"VARCHAR",
	-10	=>"VARCHAR"
	);
my %SQL_TYPE_ORACLE = (
	1	=>"CHAR",
	2	=>"NUMERIC",
	3	=>"NUMERIC",
	4	=>"NUMERIC",
	5	=>"SMALLINT",
	6	=>"FLOAT",
	7	=>"FLOAT",
	8	=>"FLOAT",
	9	=>"DATE",
	10	=>"DATE",
	11	=>"DATE",
	12	=>"VARCHAR2",
	-1	=>"LONG",
	-2	=>"SMALLINT",
	-3	=>"SMALLINT",
	-4	=>"LONG RAW",
	-5	=>"SMALLINT",
	-6	=>"SMALLINT",
	-7	=>"SMALLINT",
	-8	=>"CHAR",
	-9	=>"VARCHAR2",
	-10	=>"VARCHAR2"
	);
$SQL_TYPE_INFO->{INFORMIX} = \%SQL_TYPE_INFORMIX;
$SQL_TYPE_INFO->{ORACLE} = \%SQL_TYPE_ORACLE;
my %SQL_STANDARD_TYPE_NUM = (
	"SQL_CHAR"		=>1,
	"SQL_NUMERIC"		=>2,
	"SQL_DECIMAL"		=>3,
	"SQL_INTEGER"		=>4,
	"SQL_SMALLINT"		=>5,
	"SQL_FLOAT"		=>6,
	"SQL_REAL"		=>7,
	"SQL_DOUBLE"		=>8,
	"SQL_DATE"		=>9,
	"SQL_TIME"		=>10,
	"SQL_TIMESTAMP"		=>11,
	"SQL_VARCHAR"		=>12,
	"SQL_LONGVARCHAR"	=>-1,
	"SQL_BINARY"		=>-2,
	"SQL_VARBINARY"		=>-3,
	"SQL_LONGVARBINARY"	=>-4,
	"SQL_BIGINT"		=>-5,
	"SQL_TINYINT"		=>-6,
	"SQL_BIT"		=>-7,
	"SQL_WCHAR"		=>-8,
	"SQL_WVARCHAR"		=>-9,
	"SQL_WLONGVARCHAR"	=>-10,
	"SQL_ALL_TYPES"		=>0
	);
my %SQL_STANDARD_NUM_TYPE = (
	1	=>"SQL_CHAR",
	2	=>"SQL_NUMERIC",
	3	=>"SQL_DECIMAL",
	4	=>"SQL_INTEGER",
	5	=>"SQL_SMALLINT",
	6	=>"SQL_FLOAT",
	7	=>"SQL_REAL",
	8	=>"SQL_DOUBLE",
	9	=>"SQL_DATE",
	10	=>"SQL_TIME",
	11	=>"SQL_TIMESTAMP",
	12	=>"SQL_VARCHAR",
	-1	=>"SQL_LONGVARCHAR",
	-2	=>"SQL_BINARY",
	-3	=>"SQL_VARBINARY",
	-4	=>"SQL_LONGVARBINARY",
	-5	=>"SQL_BIGINT",
	-6	=>"SQL_TINYINT",
	-7	=>"SQL_BIT",
	-8	=>"SQL_WCHAR",
	-9	=>"SQL_WVARCHAR",
	-10	=>"SQL_WLONGVARCHAR",
	0	=>"SQL_ALL_TYPES"
);

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Function: 	Set Global Var Functions
# Description:  Set Global Var Functions
# Input:
# Output: 	
# Return:
#-----------------------------------------------------------------------
# Create Time: 2002-06-18
# Modify Time: 2002-12-05
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub Set_DataCheck
{
	$PM_DCHK	= shift;
	$OMC_ID		= shift;
	$PM_DCHK_PNAME	= shift;
	$PM_DCHK_STIME	= shift;
	$PM_DCHK_ETIME	= shift;
}

sub Set_PwdEncrypt
{
	$PwdEncrypt = shift;
}

sub Set_WriteOlog
{
	$WriteOlog = shift;
}

sub Set_MsgSend
{
	$MsgSend = shift;
}

sub Set_MSName
{
	$MSName = shift;
}

sub Set_MQName
{
	$MQName = shift;
}

sub Set_BcpMode
{
	$BcpMode = shift;
}

sub Set_BcpWnmsDatabase
{
	$Wnms_Database = shift;
}

sub Set_NoBcp
{
	$Bcp_Oldtab_Logfile = shift;
	$Use_Bcp_Oldtab = 1;
	Trace("*No Bcp with old temp tables!");
}
	
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Function:    Set_Debug
# Description: Set_Debug
# Input:
#     1.1/0
# Output: 	
# Return:
#----------------------------------------------------------------------
# Create Time: 2002-05-29
# Modify Time: 2002-05-29
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub Set_Debug
{
	my $dflag = shift;
	if ($dflag == 0)
	{
		$DeBug		= 0;
		$ErrorRollBack 	= 1;
		$ErrorCommit 	= 0;
		$ErrorExit 	= 1;
		$ErrorDebug 	= 0;
		$Del_Bcpfile	= 1;
		Trace("*Set no bebug module!\n");
	}
	elsif ($dflag == 1)
	{
		$DeBug		= 0;
		$ErrorRollBack 	= 0;
		$ErrorCommit 	= 0;
		$ErrorExit 	= 0;
		$ErrorDebug 	= 1;
		$Del_Bcpfile	= 0;
		Trace("*Set no bebug module with onerror to debug shell!\n");
	}
	elsif ($dflag == -1)
	{
		$DeBug		= 1;
		$ErrorRollBack 	= 0;
		$ErrorCommit 	= 0;
		$ErrorExit 	= 0;
		$ErrorDebug 	= 0;
		Trace("*Set bebug module to test programme without database!\n");
	}
	else
	{
		Trace("Warn: Invalid set debug!\n");
	}
}



##############################################################
# Function: 	Sort_By_Number
# Description: 	popo sort number
# Input:
#     1.@
# Output: 	@
# Return:
##############################################################
sub Sort_By_Number 
{
	my @somelist = @_;
	my ($i,$j,$a);
	for($i=0; $i < @somelist - 1;$i ++)
	{
		for ($j=$i+1; $j < @somelist;$j ++)
		{
			if (@somelist[$i]>@somelist[$j])
			{
				$a = @somelist[$i];
				@somelist[$i] = @somelist[$j];
				@somelist[$j] = $a;
			}
		}
		
	}
	return @somelist;
}

##############################################################
# Function: 	Set_Database_Type
# Description: 	Set_Database_Type
# Input:
#     1.DATABASE_TYPE
# Output: 	Null
# Return: 	string
##############################################################
sub Set_Database_Type 
{
	my $dbase = shift;
	if ($dbase =~ /oracle/i)
	{
		$COOKDB_TYPE = "ORACLE";
	}
	elsif ($dbase =~ /informix/i)
	{
		$COOKDB_TYPE = "INFORMIX";
	}
	else
	{
		Trace("Err:Not support Database Type:$dbase!\n");
	}
}

##############################################################
# Function: 	Set_OSSDB_Type
# Description: 	Set_OSSDB_Type
# Input:
#     1.DATABASE_TYPE
# Output: 	Null
# Return: 	string
##############################################################
sub Set_OSSDB_Type 
{
	my $dbase = shift;
	if ($dbase =~ /informix/i)
	{
		$OSSDB_TYPE = "INFORMIX";
	}
}

##############################################################
# Function: 	Init_Qetxt_Files
# Description: 	QETXT.INI init all table files - touch
# Input:
#     1.QETXT.INI	[with path]
# Output: 	Null
# Return: 	string
##############################################################
sub Init_Qetxt_Files 
{
	my $qfile = shift;
	my ($qetxt_dir,$line,$rfd,$wfd,$parserflag,$qdir,$tabtxt);
	if (!(-e $qfile))
	{
		Trace ("Err:Qetxt $qfile not exist!\n");
		return -1;
	}
	if ($qfile =~ /^\s*(.*)\//)
	{
		$qdir = $1;
	}
	else
	{
		$qdir = ".";
		
	}
	$rfd = new FileHandle($qfile) || die "Err:open file $qfile failed!\n";
	$parserflag = 0;
	while($line = <$rfd>)
	{
		if ($line =~ /^\s*$/)
		{
			next;
		}
		if ($line =~ /^\[Defined\s*Tables\]\s*$/i)
		{
			$parserflag = 1;
			Trace ("\nFind Defined Tables!!\n");
			next;
		}
		elsif ($line =~ /^\[.*\]\s*$/i and $parserflag == 1 )
		{
			$parserflag = -1;
			Trace ("\nDefined Tables END!!\n");
			next;
		}	
		if ($parserflag == 0)
		{
			next;
		}
		elsif($parserflag == -1)
		{
			last;
		}
		if ($line =~ /\#.*/)
		{
			next;
		}
		if($line =~ /^(.*)=\w+/)
		{
			$tabtxt = $qdir."\/".$1;
			Trace ("\nTouch file $tabtxt!!\n");
			$wfd = new FileHandle(">>".$tabtxt) || die "Err:open file $tabtxt failed!\n";
			print $wfd "";
			close($wfd);
		}
	}
	close($rfd);
	Trace ("\nTouch file End!!\n");		
}
##############################################################
# Function: 	Pwd_Encrypt
# Description: 	Pwd_Encrypt
# Input:
#     1.string
# Output: 	Null
# Return: 	string
##############################################################
sub GenerateKey {
	my $key;

	srand();
	$key = pack("C8", rand(254)+1,rand(254)+1,
		rand(254)+1,rand(254)+1,rand(254)+1,
		rand(254)+1,rand(254)+1,rand(254)+1);
	return $key;
}

sub Encode {
	my $s = shift;
	my $key = shift;
	my @sa = unpack("C*", $s);
	my @keya = unpack("C*", $key);
	my $pwd = "";
	my $chone;
	my $i;

	for($i=0; $i<$#sa+1; $i++){
		$chone = $sa[$i];
		$chone = ($chone + $keya[$i % ($#keya + 1)]) % 256;
		$pwd .= $char2hextab[$chone/16].$char2hextab[$chone%16];
	}
	return $pwd;
}

sub Pwd_Encrypt {
	my $key;

	$key = GenerateKey();
	return Encode($key, $prekey).Encode($_[0], $key);
}

##############################################################
# Function: 	Pwd_Decrypt
# Description: 	Pwd_Decrypt
# Input:
#     1.string
# Output: 	Null
# Return: 	string
##############################################################
sub Decode {
	my $s = shift;
	my $key = shift;
	my @sa = ();
	my @keya = unpack("C*", $key);

	my $i;
	for($i=0; $i<length($s)/2; $i++){
		@sa = (@sa, (hex(substr($s, $i*2, 2)) -
			$keya[$i % ($#keya + 1)]) % 256);
	}
	return pack("C*", @sa);
}

sub Pwd_Decrypt {
	my $pklen = length($prekey);
	my $part1 = substr($_[0], 0, $pklen*2);
	my $part2 = substr($_[0], $pklen*2);
	
	my $key = Decode($part1, $prekey);
	return Decode($part2, $key);
}

##############################################################
# Function: 	Trim
# Description: 	Trim string
# Input:
#     1.string
# Output: 	Null
# Return: 	string
##############################################################

sub Trim 
{
	$_ = @_[0];  
	s/^\s+//;
	s/\s+$//;
	return $_;
}

##############################################################
# Function: 	DFtime
# Description: 	time compare return day or hour or minute or second
# Input:
#     1.comp	-- DD => day hh => hour mm => minute ss => second
#     2.time1	-- standard format "YYYY-MM-DD hh:mm:ss"
#     3.time2	-- standard format "YYYY-MM-DD hh:mm:ss"
# Output: 	Null
# Return: 	integer
##############################################################
sub DFtime
{
	my $comp = shift;
	my $time1 = shift;
	my $time2 = shift;
	my $pattern = "[-:. ]";
	my @splite_list= split(/$pattern/, $time1);
	my ($syear,$smon,$sday,$shour,$smin,$ssec) = @splite_list;
	my $stime1 = timegm($ssec,$smin,$shour,$sday,($smon-1),$syear);

	@splite_list= split(/$pattern/, $time2);
	($syear,$smon,$sday,$shour,$smin,$ssec) = @splite_list;
	my $stime2 = timegm($ssec,$smin,$shour,$sday,($smon-1),$syear);
	my $span_sec = $stime1 - $stime2;
	
	if ($comp eq 'ss')
	{
		return $span_sec;
	}
	elsif ($comp eq 'mm')
	{
		return int($span_sec/60);
	}
	elsif ($comp eq 'hh')
	{
		return int($span_sec/(60*60));
	}
	elsif ($comp eq 'DD')
	{
		return int($span_sec/(60*60*24));
	}
	else
	{
		if($DeBug)
		{
			print "\nErr: Time compare expression($comp) is not anticipant!"
		}
		return;
	}	
}

##############################################################
# Function: 	GMtime
# Description: 	calculate standard "YYYY-MM-DD hh:mm:ss" time
# Input:
#     1.TIME	-- standard format (YYYY-MM-DD hh:mm:ss)
#     2.cal	-- calculation (Y/M/D/h/m/s)
#		   Such as: +1M,1D -10h
# Output: 	Null
# Return: 	standard format Time "YYYY-MM-DD hh:mm:ss"
##############################################################
sub GMtime
{
	my $gtime = shift;
	my $cal_format = shift;
	my $pattern = "[-:. ]";
	my @splite_list= split(/$pattern/, $gtime);
	my ($syear,$smon,$sday,$shour,$smin,$ssec) = @splite_list;
	my $stime = timegm($ssec,$smin,$shour,$sday,($smon-1),$syear);
	my $span = $cal_format;
	my (@day);
	$span =~ s/[YMDhms]//g;
	if ($cal_format =~ /Y/g)
	{
		$syear = $syear+$span;
		if (($syear % 4 == 0 && $syear % 100 != 0) || ( $syear % 400 == 0)) {
			@day = (0,31,29,31,30,31,30,31,31,30,31,30,31);
		}
		else {
			@day = (0,31,28,31,30,31,30,31,31,30,31,30,31);
		}
		if ($sday > @day[$smon])
		{
			$sday = @day[$smon];
		};		
		$stime = timegm($ssec,$smin,$shour,$sday,$smon - 1,$syear);
	}
	elsif($cal_format =~ /M/g)
	{
		if($span <= 0)
		{
			$smon = $smon + $span;
			while ($smon < 1)
			{
				$smon = $smon + 12;
				$syear --;
			}
		}
		else
		{
			$smon = $smon + $span;
			while ($smon > 12)
			{
				$smon = $smon - 12;
				$syear ++;
			}		
		}
		if (($syear % 4 == 0 && $syear % 100 != 0) || ( $syear % 400 == 0)) {
			@day = (0,31,29,31,30,31,30,31,31,30,31,30,31);
		}
		else {
			@day = (0,31,28,31,30,31,30,31,31,30,31,30,31);
		}
		if ($sday > @day[$smon])
		{
			$sday = @day[$smon];
		};
		$stime = timegm($ssec,$smin,$shour,$sday,$smon - 1,$syear);	
	}
	elsif($cal_format =~ /D/g)
	{
		$span = $span * 60 * 60 * 24;
		$stime = $stime + $span;
	}
	elsif($cal_format =~ /h/g)
	{
		$span = $span * 60 * 60;
		$stime = $stime + $span;
	}
	elsif($cal_format =~ /m/g)
	{
		$span = $span * 60;
		$stime = $stime + $span;
	}
	elsif($cal_format =~ /s/g)
	{
		$stime = $stime + $span;
	}
	else
	{
		return "1970-01-01 00:00:00";
	}
	($ssec,$smin,$shour,$sday,$smon,$syear) = gmtime($stime);
	$smon++;
	if ($smon < 10)
	{
		$smon = '0'.$smon;
	}
	if ($sday < 10)
	{
		$sday = '0'.$sday;
	}
	if ($shour < 10)
	{
		$shour = '0'.$shour;
	}
	if ($smin < 10)
	{
		$smin = '0'.$smin;
	}
	if ($ssec < 10)
	{
		$ssec = '0'.$ssec;
	}				
	$gtime = ($syear+1900)."-".$smon."-".$sday." ".$shour.":".$smin.":".$ssec;
	return $gtime;
}
##############################################################
# Function: 	FMtime
# Description: 	Format Time to standard "YYYY-MM-DD hh:mm:ss"
# Input:
#     1.TIME	-- Not standard format
#     2.Format	-- time formation
# Output: 	Null
# Return: 	standard format Time "YYYY-MM-DD hh:mm:ss"
##############################################################
sub FMtime
{
    my $ftime 	= shift;
    my $tformat 	= shift;
    my $tfmt = $tformat;
    my ($syear,$smon,$sday,$shour,$smin,$ssec);
    
    $tfmt =~ s/[Y]+/\(\\d\+\)/;
    $tfmt =~ s/[M]+/\\d\+/;
    $tfmt =~ s/[D]+/\\d\+/;
    $tfmt =~ s/[h]+/\\d\+/;
    $tfmt =~ s/[m]+/\\d\+/;
    $tfmt =~ s/[s]+/\\d\+/;
    
    if($ftime =~ /$tfmt/)
    {
    	$syear = $1;
    	if(!$syear)
    	{
    		$syear = '1970';
    	}
    	elsif(length($syear) == 2)
    	{
    		if ($syear < 50)
    		{
    			$syear = '20'.$syear;
    		}
    		else
    		{
    			$syear = '19'.$syear;
    		}
    	}
    	
    	if(length($syear) != 4)
    	{
    		$syear = '1970';
    	}
    }
    
    $tfmt = $tformat;
    $tfmt =~ s/[Y]+/\\d\+/;
    $tfmt =~ s/[M]+/\(\\d\+\)/;
    $tfmt =~ s/[D]+/\\d\+/;
    $tfmt =~ s/[h]+/\\d\+/;
    $tfmt =~ s/[m]+/\\d\+/;
    $tfmt =~ s/[s]+/\\d\+/;
    
    if($ftime =~ /$tfmt/)
    {
    	$smon = $1;
    	if (!$smon) 
    	{
    		$smon = '01';
    	}
    	elsif(length($smon) == 1)
    	{
    		$smon = '0'.$smon;
    	}
    	if(length($smon) != 2)
    	{
    		$smon = '01';
    	}
    }   	

    $tfmt = $tformat;
    $tfmt =~ s/[Y]+/\\d\+/;
    $tfmt =~ s/[M]+/\\d\+/;
    $tfmt =~ s/[D]+/\(\\d\+\)/;
    $tfmt =~ s/[h]+/\\d\+/;
    $tfmt =~ s/[m]+/\\d\+/;
    $tfmt =~ s/[s]+/\\d\+/;
    
    if($ftime =~ /$tfmt/)
    {
    	$sday = $1;
    	if (!$sday) 
    	{
    		$sday = '01';
    	}
    	elsif(length($sday) == 1)
    	{
    		$sday = '0'.$sday;
    	}
    	if(length($sday) != 2)
    	{
    		$sday = '01';
    	}
    }

    $tfmt = $tformat;
    $tfmt =~ s/[Y]+/\\d\+/;
    $tfmt =~ s/[M]+/\\d\+/;
    $tfmt =~ s/[D]+/\\d\+/;
    $tfmt =~ s/[h]+/\(\\d\+\)/;
    $tfmt =~ s/[m]+/\\d\+/;
    $tfmt =~ s/[s]+/\\d\+/;
    
    if($ftime =~ /$tfmt/)
    {
    	$shour = $1;
    	if (!$shour) 
    	{
    		$shour = '00';
    	}
    	elsif(length($shour) == 1)
    	{
    		$shour = '0'.$shour;
    	}
    	if(length($shour) != 2)
    	{
    		$shour = '00';
    	}
    }
    
    $tfmt = $tformat;
    $tfmt =~ s/[Y]+/\\d\+/;
    $tfmt =~ s/[M]+/\\d\+/;
    $tfmt =~ s/[D]+/\\d\+/;
    $tfmt =~ s/[h]+/\\d\+/;
    $tfmt =~ s/[m]+/\(\\d\+\)/;
    $tfmt =~ s/[s]+/\\d\+/;
    
    if($ftime =~ /$tfmt/)
    {
    	$smin = $1;
    	if (!$smin) 
    	{
    		$smin = '00';
    	}
    	elsif(length($smin) == 1)
    	{
    		$smin = '0'.$smin;
    	}
    	if(length($smin) != 2)
    	{
    		$smin = '00';
    	}
    }

    $tfmt = $tformat;
    $tfmt =~ s/[Y]+/\\d\+/;
    $tfmt =~ s/[M]+/\\d\+/;
    $tfmt =~ s/[D]+/\\d\+/;
    $tfmt =~ s/[h]+/\\d\+/;
    $tfmt =~ s/[m]+/\\d\+/;
    $tfmt =~ s/[s]+/\(\\d\+\)/;
    
    if($ftime =~ /$tfmt/)
    {
    	$ssec = $1;
    	if (!$ssec) 
    	{
    		$ssec = '00';
    	}
    	elsif(length($ssec) == 1)
    	{
    		$ssec = '0'.$ssec;
    	}
    	if(length($ssec) != 2)
    	{
    		$ssec = '00';
    	}
    }
    $ftime = $syear."-".$smon."-".$sday." ".$shour.":".$smin.":".$ssec;
    return $ftime;
}
##############################################################
# Function: 	CFtime
# Description: 	Formation current time
# Input:
#     1.Format	-- "YYYY-MM-DD hh:mm:ss"
#     2.TIME	-- CURRENT(NULL) or "YYYY-MM-DD hh:mm:ss"
# Output: 	Null
# Return: 	Format Time
##############################################################
sub CFtime
{
    my (@ctime,$tformat,$result,$ftime,$pattern,$num,$substr_time);

    $tformat 	= shift;
    $ftime 	= shift;
    $pattern = "[-:. ]";   
    if ($ftime eq "CURRENT" or $ftime eq "current" or $ftime eq "")
    {
    	@ctime = localtime;
    	$ctime[5] += 1900;
    	$ctime[4] += 1;
    }
    else
    {
    	@ctime = split(/$pattern/,$ftime);
	if ($ctime[0] !~ /^\d+$/)    	
	{
		$ctime[0] = 1970;
	}
	if ($ctime[1] !~ /^\d+$/)    	
	{
		$ctime[1] = 1;
	}
	if ($ctime[2] !~ /^\d+$/)    	
	{
		$ctime[2] = 1;
	}
	if ($ctime[3] !~ /^\d+$/)    	
	{
		$ctime[3] = 1;
	}
	if ($ctime[4] !~ /^\d+$/)    	
	{
		$ctime[4] = 0;
	}
	if ($ctime[5] !~ /^\d+$/)    	
	{
		$ctime[5] = 0;
	}
	my $i;
  	for ($i=0;$i<3;$i++)
  	{
        	$num = $ctime[5 - $i];
        	$ctime[5 - $i] = $ctime[$i];
        	$ctime[$i] = $num;
	}
    }

   my $i;						
    for ($i=0;$i<5;$i++) {
        if ($ctime[$i] < 10 and length($ctime[$i]) == 1) {
	    $ctime[$i] = "0" . $ctime[$i];
	}
    }
    
    $tformat =~ s/YYYY/$ctime[5]/g;
    $substr_time = substr($ctime[5],1,3);
    $tformat =~ s/YYY/$substr_time/g;
    $substr_time = substr($ctime[5],2,2);    
    $tformat =~ s/YY/$substr_time/g;
    $substr_time = substr($ctime[5],3,1);    
    $tformat =~ s/Y/$substr_time/g; 
 
    $tformat =~ s/MM/$ctime[4]/g;
    $substr_time = substr($ctime[4],1,1);     
    $tformat =~ s/M/$substr_time/g;

    $tformat =~ s/DD/$ctime[3]/g;
    $substr_time = substr($ctime[3],1,1);     
    $tformat =~ s/D/$substr_time/g;

    $tformat =~ s/hh/$ctime[2]/g;
    $substr_time = substr($ctime[2],1,1);     
    $tformat =~ s/h/$substr_time/g;
    
    $tformat =~ s/mm/$ctime[1]/g;
    $substr_time = substr($ctime[1],1,1);    
    $tformat =~ s/m/$substr_time/g;

    $tformat =~ s/ss/$ctime[0]/g;
    $substr_time = substr($ctime[0],1,1);    
    $tformat =~ s/s/$substr_time/g;

    $tformat =~ s/f/0/g; 
                
    return $tformat;

}
##############################################################
# Function: 	Set_Trace_Modes
# Description: 	Set TraceModes
# Input:
#     1.string  --SRC|LOG|REP
# Output: 	Null
# Return: 	Null
##############################################################

sub Set_Trace_Modes 
{
	$TraceModes = @_[0];
}    

##############################################################
# Function: 	Get_Trace_Filename
# Description: 	Get $TraceFileName
# Input:
#     
# Output: 	$TraceFileName
# Return: 	Null
##############################################################

sub Get_Trace_Filename 
{
	return $TraceFileName;
}    
##############################################################
# Function: 	Set_Mpl_Version
# Description: 	Set_Mpl_Version
# Input:
#
# Output: 	Null
# Return: 	Null
##############################################################

sub Set_Mpl_Version
{
	$MPL_VERSION = @_[0];
	my $map_ver = @_[1];
	Trim($map_ver);
	if ($map_ver)
	{
		$MAP_VERSION = $map_ver;
	}
}

##############################################################
# Function: 	Init_Trace
# Description: 	Initiates trace information including 
# Input:
#     1.Trace Module
#     2.Trace Dir	  -- first with "/" absoluteness dir else relatively
#     3.argv ref positin
# Output: 	Null
# Return: 	Null
##############################################################

sub Init_Trace 
{
    my ($trace_mod,$trace_dir,$argv_ref) = @_;
    my (@trace_subdir,$sub_dir,$fetchdir,$tracetime,$filetime);
    my $PROG_NAME = $0.' '.$argv_ref;
    $TraceModes = "LOG|SRC";
	
    if ($trace_dir !~ /\/$/){
	$trace_dir .= "/";
    }
    if ($trace_dir !~ /^\//){
	$trace_dir = "$DAL_HOME/NPM/trace/$trace_dir";
    }

    if (-e $trace_dir && -d $trace_dir)
    {
	unless (-w $trace_dir)
	{
	    print "Err: Write trace failed because of $^E\n";
	    NPM_Send_Message(203);
	    NPM_Write_DalLog(ERROR_MESSAGE=>"Err: Write trace failed because of $^E");
	    exit 0;
	}
    }
    else
    {
	@trace_subdir = split (/\//,$trace_dir);
	foreach $sub_dir (@trace_subdir)
	{
	    if ($sub_dir)
	    {
	        $fetchdir = $fetchdir."/".$sub_dir;
	    	if (!-e $fetchdir)
	    	{
	    	    my $result;
		    unless ($result = mkdir($fetchdir,0755))
		    {
	    		print "Err: Create trace directory --$fetchdir failed because of $^E\n";
        		NPM_Send_Message(204);
	    	        NPM_Write_DalLog(ERROR_MESSAGE=>"Err: Create trace directory --$fetchdir failed because of $^E");
	    		exit 0;
        	    }
		}
	    }
	}   	
    }

    $tracetime = CFtime("YYYY-MM-DD hh:mm:ss");
    $filetime = CFtime("YYYYMMDDhhmmss"); 
    
    $TraceFileName = $trace_dir."$trace_mod.$filetime.log";
#    $RepFileName = $trace_dir."$trace_mod.$filetime.report";
    $RepFileName = "/dev/null";
    $Data_Load_TmpDir = $trace_dir.$filetime;
    open (OUTPUT, ">>$TraceFileName");
    select((select(OUTPUT), $| = 1)[0]);

    open (REPORT, ">>$RepFileName");
    select((select(REPORT), $| = 1)[0]);
    my $init_inf =<<EOF;
=================================================
Command:\t$0
Input:\t\t$argv_ref
Execute Time:\t$tracetime
Process ID:\t$$
User ID:\t$<
DBIs VERSION:\t$DBIs_VERSION
mPerl VERSION:\t$MPL_VERSION
Mapping VERSION:$MAP_VERSION
=================================================
REPORT:
EOF
    print REPORT $init_inf;
    if ($WriteOlog)
    {
    	my $task_id;
	if ($argv_ref =~ /-j\s+(\w+)\s*/)
	{
		$task_id = $1;
	}
	$DMMMT_DCMSG_TASK_ID = $task_id if(defined($task_id));
	$DMMMT_DCMSG_INSTANCE_RDN = 'DATA_ASM:'.$argv_ref;
	Write_OlogDB();
	
    }
    if ($MsgSend)
    {
	my $msg = FmtMsg($init_inf);
	MQSend($msg);
    }    
    return $TraceFileName;
}


###########################################################################
# Function: Trace
# Description: It writes the trace   
# Input:
#     1.  Trace String
#     2.  WithTime
# Output: Null
# Return: Null
###########################################################################
sub Trace
{
	my ($withtime,$wtrace,$datetime,$strace,$tracefile,$datetime,$line,$lines,$output,$len,$withtime);
	$strace = shift;
	$withtime = shift;
	$wtrace = $TraceModes;
	$datetime = CFtime("YYYY-MM-DD hh:mm:ss");
	my @lines = split(/\n/, $strace);
	foreach $line (@lines) 
	{
		if (length($line) > 70 )
		{
			$len = 0;
			while ($len < length($line))
			{
				$output .= "\t".substr($line,$len,70)."\n";
				$len += 70;
			}
		}
		else 
		{
			$output .= "\t".$line."\n";
		}
	}
	if ($withtime == 1 or $withtime eq "")
	{
		$output = "\n".$datetime.":\n--------------------\n".$output;
	}

	if ($wtrace =~/SRC/i)
	{
		print $output;
	}
	if ($wtrace =~/LOG/i)
	{
		print OUTPUT $output;
	}
	if ($wtrace =~/REP/i)
	{
		print REPORT $output;
		if ($MsgSend)
		{
			my $msg = FmtMsg($output);
			MQSend($msg);
		}
	}		

#	$~ = "PRINTFORMAT";
#format PRINTFORMAT =
#
#@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#$datetime
#-------------------------
#~~  ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#$strace
#.	
}

###########################################################################
# Function: End_Trace
# Description: the trace end
# Input:  Null
# Output: Null
# Return: Null
###########################################################################
sub End_Trace {

	my $datetime = CFtime("YYYY-MM-DD hh:mm:ss");

#	print REPORT "\n******************************************";	
#	print REPORT "\nExecute End Time:\t$datetime";
#	print REPORT "\n******************************************";	
    my $init_inf =<<EOF;
******************************************	
Execute End Time:\t$datetime
******************************************
EOF
    	print REPORT $init_inf;
	if ($WriteOlog)
	{
		Write_OlogDB(1);
	}
	if ($MsgSend)
	{
		my $msg = FmtMsg($init_inf);
		MQSend($msg);
	} 		
	close (OUTPUT);
	close (REPORT);
}

###########################################################################
# Function: Connect_DB
# Description: Connect Database
# Input:  
#	1.dbh pointer
#	2.auto commit flag
# Output: Null
# Return: Null
###########################################################################
sub Connect_DB
{
	my ($subdbh,$auotcommit);
	$subdbh = shift;
	$auotcommit = shift;
	
	if (!$auotcommit)
	{
		$auotcommit = 0;	
	}
	
	my ($sub_dbd,$sub_dbn,$sub_uid,$sub_pwd,$sub_mark)=Get_DBMS();
	
	if(!$sub_dbn or !$sub_dbd)
	{
		Trace("Err:Please Set_DBMS\($sub_mark\)\n\tCONN_DBD\t=\t$sub_dbd\n\tCONN_DBN\t=\t$sub_dbn\n\tCONN_UID\t=\t$sub_uid\n\tCONN_PWD\t=\t*****");
		NPM_Send_Message(201);
		NPM_Write_DalLog(ERROR_MESSAGE=>"Err: Incorrect db_type or db_name in LDAP");
		exit 0;
	}
	Trace("Connecting Database DBI:$sub_dbd:$sub_dbn $sub_uid/*****\n");
	
	if ($DeBug)
	{
		Trace("***Programming Debug!! return!!!\n");
		return 0;
	} 
	if($$subdbh=DBI->connect("DBI:$sub_dbd:$sub_dbn",$sub_uid,$sub_pwd,
	{RaiseError => 0,PrintError => 0, AutoCommit => $auotcommit }))
	{
		Trace("Connect Database DBI:$sub_dbd:$sub_dbn success!\n");
		return 1;
	}
	else
	{
		Trace("Err:Connect Database DBI:$sub_dbd:$sub_dbn error!\nErr Info:$DBI::errstr\n");
		NPM_Send_Message(202);
		NPM_Write_DalLog(ERROR_MESSAGE=>"$DBI::errstr");
		Write_Dchk_Err("Err:Connect Database DBI:$sub_dbd:$sub_dbn error!\nErr Info:$DBI::errstr\n") if $PM_DCHK;
		exit 0;
		return 0;
	}
}
###########################################################################
# Function: Disonnect_DB
# Description: Disonnect Database
# Input:  
#	1.dbh pointer
# Output: Null
# Return: Null
###########################################################################

sub Disonnect_DB
{
   my ($rc,$subdbh);
   
   $subdbh = shift;

   if ($DeBug)
   {
   	Trace("Disconnect Database!\n");
   	Trace("***Programming Debug!! return!!!\n");
   	return 0;
   }

   $rc = $$subdbh->disconnect;
   if($rc)
   {
	Trace("Disconnect Database!\n");
	return 1;
   }
   else
   {
 	Trace("Err:Disconnect Database error!\nErr Info:$DBI::errstr\n");
	return 0;
   }
}
###########################################################################
# Function: Commit_DB
# Description: Commit Database
# Input:  
#	1.dbh pointer
# Output: Null
# Return: Null
###########################################################################

sub Commit_DB
{
   my ($rc,$subdbh);
   
   $subdbh = shift;

   if ($DeBug)
   {
   	Trace("Commited Transecation To Database!\n");
   	Trace("***Programming Debug!! return!!!\n");
   	return 0;
   }  

   
   $rc = $$subdbh->commit;
   if($rc)
   {
	Trace("Commited Transecation To Database!\n");
	return 1;
   }
   else
   {
	Trace("Err:Commited Transecation To Database Error!\nErr Info:$DBI::errstr\n");
	return 0;
   }
}

###########################################################################
# Function: Rollback_DB
# Description: Rollback_DB
# Input:  
#	1.dbh pointer
# Output: Null
# Return: Null
###########################################################################
sub Rollback_DB
{
   my ($rc,$subdbh);
   
   $subdbh = shift;

   if ($DeBug)
   {
   	Trace("Rollbacked Transecation From Database !\n");
   	Trace("***Programming Debug!! return!!!\n");
   	return 0;
   } 
   
   $rc = $$subdbh->rollback;
   if($rc)
   {
	Trace("Rollbacked Transecation From Database !\n");
	return 1;
   }
   else
   {
	Trace("Err:Rollbacked Transecation From Database Error!\nErr Info:$DBI::errstr\n");
	return 0;
   }
}

###########################################################################
# Function: Exec_Sql
# Description: execute sql statement 
# Input:  
#	1.dbh pointer
#       2.sth_pointer
#	3.sql_statement
#       4.[flag_hold]          --0 not hold and exec finish at end
#       5.flag bind	       --1 bind parameters or not 
#       6.bind_para point            
# Output: None
# Return: undef : Failure
#	  rows	: Successful
###########################################################################
sub Exec_Sql
{
	my($subdbh,$substh,$sub_statement,$subflag,$rows,$sub_rc);
	my($sub_bind,$bind,@bind_paras,$bind_para,@paras,$i);
	$subdbh 	= shift;
	$substh 	= shift;
	$sub_statement 	= shift;
	$subflag 	= shift;
	$bind 		= shift;
	$bind_para	= shift;

	$sub_statement=Replace_SQL_Standard_Type($sub_statement);

	my $currenttime = CFtime('YYYY-MM-DD hh:mm:ss');
	
	$sub_statement =~ s/\bCURRENT\b/\'$currenttime\'/g;
	
	Trace("Exec SQL:\n".$sub_statement);

	if ($DeBug)
	{
	   	Trace("***Programming Debug!! return!!!\n");
	   	return 0;
	} 
	
	if(!($$substh = $$subdbh->prepare($sub_statement)))
	{
		$TraceModes = 'SRC|LOG|REP';		
		Trace("Err:Sql prepare error!\nSQL Statement:$sub_statement\nErr Info:".$DBI::errstr);
		NPM_Send_Message(210);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		$TraceModes = 'SRC|LOG';
		return 0;
	}
	if ($bind == 1)
	{
		@bind_paras = $bind_para =~ /\([^\(\)]*\)/g;
		$i = 0;
		foreach $bind_para (@bind_paras)
		{
#			$bind_para = eval($bind_para);
			$bind_para =~ s/\(|\)//g;
			@paras = split(",",$bind_para);
			@paras[2] = eval(@paras[2]);
			Trace("Bind Parameter:$bind_para\n\tParaNo.@paras[0] = @paras[1]");
			$i ++;
			if (@paras[0] != $i)
			{
					Trace("Err:Bind Parameter error!Parameter:@paras");
			}
			else
			{
				$sub_rc = $$substh->bind_param(@paras);
				if (not $sub_rc)
				{
					$TraceModes = 'SRC|LOG|REP';			
					Trace("Err:Execute sql bind error!bind_param\(@paras\)");
					NPM_Send_Message(211);
					NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
					return 0;
				}
			}
			
		}
	}
	$sub_rc = $$substh->execute();
	if(not $sub_rc)
	{
		$TraceModes = 'SRC|LOG|REP';			
		Trace("Err:Execute sql error!\nSQL Statement:$sub_statement\nErr Info:".$DBI::errstr);
		NPM_Send_Message(212);
		NPM_Write_DalLog(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		$TraceModes = 'SRC|LOG';
		return 0;
	}
	
	$rows = $$substh->rows;
	
	if ($subflag == 0)
	{
		$$substh->finish;
		$$substh = $rows;
	}

	Trace("Exec SQL Finished! $rows rows affected!\n");
	return $rows;
}
###########################################################################
# Function: Set_Isdirty_Read
# Description: set isolation dirty to read as informix database
# Input:  
#	1.dbh pointer
#	2.db type
# Output: Null
# Return: Null
###########################################################################
sub Set_Isdirty_Read
{
	my($subdbh,$substh,$db_type,$sql_statement,$sub_rc);
	$subdbh 	= shift;
	$db_type	= shift;
	$sql_statement = 'set isolation dirty read';
	Trace("\n*Set isolation dirty read!\n",0);
	if ($db_type ne 'INFORMIX')
	{
	   	Trace("***This attribute can not support $db_type database type!\n",0);
	   	return 0;
	} 
	if ($DeBug)
	{
	   	Trace("***Programming Debug!! return!!!\n",0);
	   	return 0;
	} 
	
	if(!($substh = $$subdbh->prepare($sql_statement)))
	{
		$TraceModes = 'SRC|LOG|REP';		
		Trace("Warning:Set isolation dirty read error! ".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		return 0;
	}

	if(!($substh->execute()))
	{
		$TraceModes = 'SRC|LOG|REP';			
		Trace("Warning:Set isolation dirty to read error".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		return 0;
	}
	if (!$Lock2WaitSec)
	{
		$Lock2WaitSec = 0;
	}
	$sql_statement = "set lock mode to wait $Lock2WaitSec";
	Trace("\n*Set Lock to wait $Lock2WaitSec!\n",0);
	if ($db_type ne 'INFORMIX')
	{
	   	Trace("***This attribute can not support $db_type database type!\n",0);
	   	return 0;
	} 
	
	if(!($substh = $$subdbh->prepare($sql_statement)))
	{
		$TraceModes = 'SRC|LOG|REP';		
		Trace("Warning:Set lock to wait error! ".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		return 0;
	}

	if(!($substh->execute()))
	{
		$TraceModes = 'SRC|LOG|REP';			
		Trace("Warning:Set lock to wait error! ".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		return 0;
	}
}
###########################################################################
# Function: Find_Bcp_Oldtab
# Description: 
###########################################################################
sub Find_Bcp_Oldtab
{
	my $mask = shift;
	my $logfile = shift;
	my $tmptable;
	if(!$logfile or !(-e $logfile))
	{
		Trace("Warning:Find_Bcp_Oldtab log file null or not exist!");
		return;
	}
	if(!open(OF,$logfile))
	{
		Trace("Err:Find_Bcp_Oldtab open log file error!");
	}
	
	while(<OF>)
	{
		if(/Bcp\($mask\) to (\w+) SQL:/)
		{
			$tmptable = $1;
			last;
		}
	}
	close(OF);
	return $tmptable;
}
###########################################################################
# Function: Bcp
# Description: execute sql statement 
# Input:  
#\$db_dbh,\$bcp_dbh,\$bcp_tab,$statement,$bind,$bind_para
#	1.dbh pointer
#       2.bcp_dbh pointer
# 	3.bcp_tab
#	4.sql_statement
#       5.flag bind	       --1 bind parameters or not 
#       6.bind_para point            
# Output: Null
# Return: Null
###########################################################################
sub Bcp
{
	use FileHandle;
	my($subdbh,$substh,$subcpdbh,$subcpsth,$subcptab,$sub_statement,$subflag,$rows,$sub_rc);
	my($sub_bind,$bind,@bind_paras,$bind_para,@paras,$i,$errows,$rv);
	my ($i,$counter,$colnum,$coltype,@cols_type,$colname,$counter_sql,$counter_num,
	    $colscale,$colprec,$tabschema,$cols,$cols_noid,$value_cols,$ins_sql,$type,
	    $serial_id,$oldbcptab);
	my (@fetchrow,$ROWS,$line);
	
	$subdbh 	= shift;
	$subcpdbh 	= shift;
	$subcptab	= shift;
	$sub_statement 	= shift;
	$bind 		= shift;
	$bind_para	= shift;
	
	$Bcptab_Serial ++;
	if($Use_Bcp_Oldtab)
	{
		if(!$Bcp_Oldtab_Logfile or !(-e $Bcp_Oldtab_Logfile))
		{
			Trace("Warning: Can not use bcp old table because of old log file null or not exist!");
			$Use_Bcp_Oldtab = 0;
		}
		else
		{
			$oldbcptab = Find_Bcp_Oldtab($Bcptab_Serial,$Bcp_Oldtab_Logfile);
			if(!$oldbcptab)
			{
				Trace("Warning: Can not use bcp old table because of old log file null or not exist!");
			}
			else
			{
				Trace("Bcp($Bcptab_Serial) to $$subcptab SQL:\n".$sub_statement);
				Trace("Use old bcp table $oldbcptab!!\n");
				$$subcptab = $oldbcptab;
				return 0;
			}
		}
	}

	Trace("Bcp($Bcptab_Serial) to $$subcptab SQL:\n".$sub_statement);
	Set_Isdirty_Read($subdbh,$OSSDB_TYPE);
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# count all data number
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	if(!$$ErrorDebug)	#if Error bebug then counter rows
	{
		$counter_sql = $sub_statement;
		
		if(!($substh = $$subdbh->prepare($counter_sql)))
		{
			$TraceModes = 'SRC|LOG|REP';	
			Trace("Bcp SQL Statement:\n$counter_sql\nErr Info:".$DBI::errstr);
			$TraceModes = 'SRC|LOG';
			NPM_Send_Message(210);
			NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
			OnError($subdbh);
			return -1;
		}
		$sub_rc = $substh->execute();	
		$counter_num = 0;
		while(@fetchrow = $substh->fetchrow_array)
		{
			$counter_num ++;
		}
		$substh->finish;
	}
	else
	{
		$counter_num = 'unknown';
	}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	if ($DeBug)
	{
	   	Trace("***Programming Debug!! return!!!\n");
	   	return -1;
	} 
	if(!($substh = $$subdbh->prepare($sub_statement)))
	{
		$TraceModes = 'SRC|LOG|REP';			
		Trace("Err:Sql prepare error!\nSQL Statement:$sub_statement\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(210);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}

	if ($bind == 1)
	{
		@bind_paras = $bind_para =~ /\([^\(\)]*\)/g;
		$i = 0;
		foreach $bind_para (@bind_paras)
		{
			$bind_para =~ s/\(|\)//g;
			@paras = split(",",$bind_para);
			@paras[2] = eval(@paras[2]);
			Trace("Bind Parameter:$bind_para\n\tParaNo.@paras[0] = @paras[1]");
			$i ++;
			if (@paras[0] != $i)
			{
					Trace("Err:Bind Parameter error!Parameter:@paras");
			}
			else
			{
				$sub_rc = $substh->bind_param(@paras);
				if (not $sub_rc)
				{
					$TraceModes = 'SRC|LOG|REP';	
					Trace("Err:Execute sql bind error!bind_param\(@paras\)");
					$TraceModes = 'SRC|LOG';
					NPM_Send_Message(211);
					NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
					OnError($subdbh);
					return -1;
				}
			}
			
		}
	}
	$sub_rc = $substh->execute();
	if(not $sub_rc)
	{
		$TraceModes = 'SRC|LOG|REP';	
		Trace("Err:Execute sql error!\nSQL Statement:$sub_statement\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(212);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}
	
	Trace ("\nSQL Info:\n",0);
	
	Trace ("Column Name	    TypeName            DataType   Precision  Scale\n",0);
	Trace ("===================================================================\n",0);

	
	$colnum = $substh->{NUM_OF_FIELDS};
	my ($col_infor,$spaces,$infor_tmp);
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Serial Id
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	$colname = $$subcptab."_ID";
	$cols = $colname.",";
	$coltype = $SQL_TYPE_INFO->{$COOKDB_TYPE}->{4};
	#SQL_INTEGER
	$tabschema 	.= $colname."\t".$coltype.",\n";
	Trace ("$colname  SQL_INTEGER         4          -          -    \n",0);
	$serial_id = 0;
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	for($i=0;$i<$colnum;$i++)
	{
#		@typenames 	= map {scalar $dbh->type_info($_)->{TYPE_NAME} } @{ $sth->{TYPE} }
		$type		= $substh->{TYPE}->[$i];
		@cols_type[$i]	= $type;
		#$coltype 	= $$subcpdbh->type_info($type)->{TYPE_NAME};
		$coltype 	= $SQL_TYPE_INFO->{$COOKDB_TYPE}->{$type};
		$colname 	= $substh->{NAME}->[$i];
		$colscale 	= $substh->{SCALE}->[$i];
		$colprec 	= $substh->{PRECISION}->[$i];
		$infor_tmp	= $colname;
		$col_infor      = $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 20 - length($infor_tmp);
		$col_infor     .= $spaces;
		
		$infor_tmp	= $SQL_STANDARD_NUM_TYPE{$type};
		$col_infor     .= $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 20 - length($infor_tmp);
		$col_infor     .= $spaces;
		
		$infor_tmp	= $type;
		$col_infor     .= $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 11 - length($infor_tmp);
		$col_infor     .= $spaces;

		$infor_tmp	= $colprec;
		$col_infor     .= $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 11 - length($infor_tmp);
		$col_infor     .= $spaces;

		$infor_tmp	= $colscale;
		$col_infor     .= $infor_tmp;

		Trace ("$col_infor",0);
		
		if ($colscale <= 0 or $colscale >= $colprec)
		{
			$colscale = 0;
		}
		if($type == 1 or $type == 12 or $type == -1)
		{
			if (($type == 12 or $type == -1) and $colprec > 255)
			{
				$colprec = 255;
			}			
			$coltype = $coltype."(".$colprec.")";
		}
		if($type == 3)
		{
			if ($colprec > 255)
			{
				$colprec = 255;
			}
			$coltype = $coltype."(".$colprec.",".$colscale.")";
		}
		if($type == 2)
		{
			if ($colscale > 0)
			{
				$coltype = $SQL_TYPE_INFO->{$COOKDB_TYPE}->{3};
				$coltype = $coltype."(".$colprec.",".$colscale.")";
			}
		}
		$tabschema 	.= $colname."\t".$coltype.",\n";
		$cols_noid 	.= $colname.","

	}
	chomp($tabschema);
	chop($tabschema);

#	$tabschema .= "PRIMARY KEY (".$$subcptab."_ID)";

	chomp($cols_noid);
	chop($cols_noid);	
	
	$cols = $cols.$cols_noid;
	
	Trace ("===================================================================\n",0);
	$tabschema = "CREATE TABLE $$subcptab\n\(\n".$tabschema."\n\)";
	Trace("\nCREATE TABLE SQL:\n".$tabschema,0);

	if(!($subcpsth = $$subcpdbh->prepare($tabschema)))
	{
		$TraceModes = 'SRC|LOG|REP';	
		Trace("Bcp create table statement:\n$tabschema\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(210);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}
	if(!($subcpsth->execute()))
	{
		$TraceModes = 'SRC|LOG|REP';	
		Trace("Bcp create table statement:\n$tabschema\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(212);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}	
	
	$$subcpdbh->commit;
	
	$TraceModes = 'SRC|LOG';
	Trace("\nBcp all of $counter_num rows to table $$subcptab!!\n",0);
	$TraceModes = "";
#----------------------------INSERT From local database--------------
# This is Not right so can not use
#--------------------------------------------------------------------
	if ($BcpMode == 3)
	{
		$ins_sql = "insert into $$subcptab (".$cols_noid.")\n$sub_statement";
		$TraceModes = 'SRC|LOG';
		Trace("\nBcp from local database(or db link mode)!!\n\n$ins_sql\n",0);
		if(!($rv  = $$subcpdbh->do($ins_sql)))
		{
			$TraceModes = 'SRC|LOG|REP';		
			Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
			$TraceModes = 'SRC|LOG';
			NPM_Send_Message(250);
			NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
			OnError($subdbh);
			return -1;
		}
		$TraceModes = 'SRC|LOG';
		Trace("Bcp Finished!\n",0);
		return 0;		
	}
#----------------------------INSERT WITH LOAD------------------------
# This is Not right so can not use
#--------------------------------------------------------------------
	if(($COOKDB_TYPE eq 'ORACLE') and ($BcpMode == 2))
	{
		$TraceModes = 'SRC|LOG|REP';
		Trace("Warning:Oracle database can not use bcp load at present!\n");
		$TraceModes = 'SRC|LOG';
		$BcpMode = 0;
	}
#	if ($BcpMode == 2)
#	{
#
#		if (!(-e "$INFORMIXDIR/bin/dbload"))
#		{
#			$TraceModes = 'SRC|LOG|REP';
#			Trace("Warning:$INFORMIXDIR/bin/dbload not exist,can not use bcp load at present!\n");
#			$TraceModes = 'SRC|LOG';
#			$BcpMode = 0;
#		}		
#	}
	if ($BcpMode == 2)
	{
		if(!$Data_Load_TmpDir)
		{
			$Data_Load_TmpDir = "$DAL_HOME/tmp/dbload";
		}
		my $dbloaddatfile 	= "$Data_Load_TmpDir/$$subcptab.unl";
		my $dbloadcmdfile 	= "$Data_Load_TmpDir/$$subcptab.cmd";
		my $dbloadlogdfile 	= "$Data_Load_TmpDir/$$subcptab.log";
		my $dbloadsql		= "$Data_Load_TmpDir/$$subcptab.sql";
		my $dbloadcmd 		= "$INFORMIXDIR/bin/dbload -d $Wnms_Database -c $dbloadcmdfile -l $dbloadlogdfile";

#----------------------------------------------------------------------------		
#dbload [-d dbname] [-c cfilname] [-l logfile] [-e errnum] [-n nnum]
#        [-i inum] [-s] [-p] [-r | -k] [-X]
#
#        -d      database name
#        -c      command file name
#        -l      bad row(s) log file
#        -e      bad row(s) # before abort
#        -s      syntax error check only
#        -n      # of row(s) before commit
#        -p      prompt to commit or not on abort
#        -i      # or row(s) to ignore before starting
#        -r      loading without locking table
#        -X      recognize HEX escapes in character fields
#        -k      loading with exclusive lock on table(s)
#----------------------------------------------------------------------------
		
		if (!(-e "$Data_Load_TmpDir") or !(-d "$Data_Load_TmpDir"))
		{
			&Touch_Dir("$Data_Load_TmpDir");
		}
		
		if(!(open(CMDFILE,">".$dbloadcmdfile)))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Create dbload cmd file $dbloadcmdfile error!\n");
			$TraceModes = 'SRC|LOG';
			OnError($subcpdbh);
			return -1;			
		}
		
		print CMDFILE "FILE $Data_Load_TmpDir/$$subcptab.unl DELIMITER \'|\' ".($colnum+1).";\n";
		print CMDFILE "INSERT INTO $$subcptab;";	
		close(CMDFILE);

		$TraceModes = 'SRC|LOG';
		Trace("\nBcp with Load to File $dbloaddatfile!!Waiting...\n",0);
		$TraceModes = "";
		my $dfile = new FileHandle(">$dbloaddatfile");
		if(!defined $dfile)
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Open data file $dbloaddatfile error!\n");
			$TraceModes = 'SRC|LOG';
			OnError($subcpdbh);
			return -1;			
		}

		$serial_id = 0;
		my $file_buf;
		while(@fetchrow = $substh->fetchrow_array)
		{
			$line = "";
			$serial_id ++;
			$line = $serial_id.'|';
			for($i=0;$i<@fetchrow;$i++)
			{
				@fetchrow[$i] = Trim(@fetchrow[$i]);
				if ($substh->{TYPE}->[$i] == 11)
				{
					if (@fetchrow[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
					{
						@fetchrow[$i] = $1;
					}
				}
				$line .= @fetchrow[$i]."|";
				
			}
			chop($line);
			$file_buf .= $line."\n";
			$rows ++;
			if (($rows % 1000) == 0)
			{
				print $dfile $file_buf;
				undef $file_buf;
				printf ("\n\t%7d of $counter_num rows have finished!",$rows);
				
			}
		}
		print $dfile $file_buf;
		undef $file_buf;
		close($dfile);
		
		$TraceModes = 'SRC|LOG';
		Trace("\nBcp with Load To Table $$subcptab!!Waiting...\n\n",0);
		
		if(!(open(CMDSQL,">".$dbloadsql)))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Create dbload cmd file $dbloadcmdfile error!\n");
			$TraceModes = 'SRC|LOG';
			OnError($subcpdbh);
			return -1;			
		}
		print CMDSQL "Load from $dbloaddatfile delimiter \'|\' insert into $$subcptab";
		close(CMDSQL);
		$net->cmd("dbaccess mddb $dbloadsql");
		$net->close;
		
		
		#system($dbloadcmd);
		if($Del_Bcpfile)
		{
			unlink($dbloaddatfile);
			unlink($dbloadcmdfile);
			unlink($dbloadlogdfile);
		}
		Trace("Bcp Finished!\n",0);
		return 0;
	}
#----------------------------INSERT NOT BIND------------------------
  
	if ($BcpMode == 0)
	{
		if ($BcpBuffer)
		{
			$TraceModes = 'SRC|LOG';
			Trace("\nBcp not Bind to Buffer!!Waiting...\n",0);
			$TraceModes = "";
			my (@fetchrow,$ary_ref,$rows,$row_ref);
			while(@fetchrow = $substh->fetchrow_array)
			{
				push(@$ary_ref,[@fetchrow]);
				$rows ++;
				if (($rows % 5000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$rows);
				}
			}
			$counter_num = $counte;
			$TraceModes = 'SRC|LOG';	
			Trace("\nBcp not Bind to Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";
			$serial_id = 0;
			foreach $row_ref (@$ary_ref)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++;
				$value_cols = "\'".$serial_id."\',";
#-------------optimize not use Time (2002-01-01 00:00:00.000=>2002-01-01 00:00:00)------------
				for($i=0;$i<@$row_ref;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@$row_ref[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@$row_ref[$i] = $1;
						}
					}
					$value_cols .= "\'".@$row_ref[$i]."\',";
					
				}
				chomp($value_cols);
				chop($value_cols);
#---------------------------------------------------------------------------------------------
#				$value_cols = join("\',\'",@$row_ref);
#				$value_cols = "\'".$value_cols."\'";
#---------------------------------------------------------------------------------------------				
				$ins_sql = "insert into $$subcptab (".$cols.")values(".$value_cols.");";
#				&Exec_Sql($subcpdbh,\$subcpsth,$ins_sql);
#--------------------------------optimize not use Exec_Sql--------------------------------
				if(!($rv  = $$subcpdbh->do($ins_sql)))
				{
					$TraceModes = 'SRC|LOG|REP';		
					Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
					$TraceModes = 'SRC|LOG';
#					OnError($subdbh);
				}
#--------------------------------------------------------------------------------				
				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
				}
			}
			$counter_num = $counter;
			undef($ary_ref);
			$TraceModes = 'SRC|LOG';
		
			Trace("\nBcp Finished! $counter rows!\n",0);
			$substh->finish;			
		}
		else
		{
			$TraceModes = 'SRC|LOG';			
			Trace("\nBcp not Bind To Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";
			my @fetchrow;
			$serial_id = 0;
			while(@fetchrow = $substh->fetchrow_array)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++;
				$value_cols = "\'".$serial_id."\',";
#-------------optimize not use Time (2002-01-01 00:00:00.000=>2002-01-01 00:00:00)------------
				for($i=0;$i<@fetchrow;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@fetchrow[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@fetchrow[$i] = $1;
						}
					}
					$value_cols .= "\'".@fetchrow[$i]."\',";
					
				}
				chomp($value_cols);
				chop($value_cols);
#---------------------------------------------------------------------------------------------
#				$value_cols = join("\',\'",@fetchrow);
#				$value_cols = "\'".$value_cols."\'";
#---------------------------------------------------------------------------------------------
				$ins_sql = "insert into $$subcptab (".$cols.")values(".$value_cols.");";
#--------------------------------optimize not use Exec_Sql--------------------------------
#				&Exec_Sql($subcpdbh,\$subcpsth,$ins_sql);
#---------------------------------------------------------------------------------------------
				if(!($rv  = $$subcpdbh->do($ins_sql)))
				{
					$TraceModes = 'SRC|LOG|REP';		
					Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
#					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
				}
#--------------------------------------------------------------------------------				

				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
				}
			}
			$TraceModes = 'SRC|LOG';
		
			Trace("Bcp Finished! $counter rows!\n",0);
			$substh->finish;
		}
		Commit_DB($subcpdbh);
		return $counter;
	}
#----------------------------INSERT WITH BIND------------------------
	if ($BcpMode == 1)
	{
		$value_cols = "?";
		for($i=0;$i<$colnum;$i++)
		{
			if ($value_cols)
			{
				$value_cols .= ',?';
			}
			else
			{
				$value_cols = '?';
			}
		}
		$ins_sql = "insert into $$subcptab (".$cols.")values(".$value_cols.");";
	
		if(!($subcpsth = $$subcpdbh->prepare($ins_sql)))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Bcp insert bind sql prepare error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
			NPM_Send_Message(210);
			NPM_Write_DalLog(ERROR_MESSAGE=>"$DBI::errstr");
			OnError($subcpdbh);
			return -1;
		}
		if ($BcpBuffer)
		{
			$TraceModes = 'SRC|LOG';
			Trace("\nBcp with Bind to Buffer!!Waiting...\n",0);
			$TraceModes = "";
			my (@fetchrow,$ary_ref,$rows,$row_ref);
			while(@fetchrow = $substh->fetchrow_array)
			{
				push(@$ary_ref,[@fetchrow]);
				$rows ++;
				if (($rows % 5000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$rows);
				}
			}
			$counter_num = $counte;
			$TraceModes = 'SRC|LOG';			
			Trace("\nBcp with Bind To Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";
			$serial_id = 0;
			foreach $row_ref (@$ary_ref)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++;
				for($i=0;$i<@$row_ref;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@$row_ref[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@$row_ref[$i] = $1;
						}
					}
				}
				unshift(@$row_ref,$serial_id);
				if(!($subcpsth -> execute(@$row_ref)))
				{
					$TraceModes = 'SRC|LOG|REP';
					$errows = join(",",@$row_ref);
					Trace("Err:Bcp insert date error!\nInsert values:$errows\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
#					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
				}
			
				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
				}
			}
			undef($ary_ref);		
			$TraceModes = 'SRC|LOG';
		
			Trace("Bcp Finished! $counter rows!\n",0);
			$substh->finish;		
		}
		else
		{
			
	
			$TraceModes = 'SRC|LOG';			
			Trace("\nBcp with Bind To Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";	
			my @fetchrow ;	
			$serial_id = 0;
			while(@fetchrow = $substh->fetchrow_array)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++ ;
				for($i=0;$i<@fetchrow;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@fetchrow[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@fetchrow[$i] = $1;
						}
					}
				}
				unshift(@fetchrow,$serial_id);
				if(!($subcpsth -> execute(@fetchrow)))
				{
					$TraceModes = 'SRC|LOG|REP';
					$errows = join(",",@fetchrow);
					Trace("Err:Bcp insert date error!\nInsert values:$errows\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
#					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
				}
			
				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
	
				}
			}
			$TraceModes =  "SRC|LOG";
		
			Trace("Bcp Finished! $counter rows!\n",0);
			$substh->finish;
		}
		Commit_DB($subcpdbh);
		return $counter;
	}
}

###########################################################################
# Function: Exec_Finish
# Description: execute sql statement finish 
# Input:  
#	1.sth pointer
# Output: Null
# Return: Null
###########################################################################
sub Exec_Finish
{
	my ($substh,$subrc);

	$substh = shift;
	if ($DeBug)
	{
		Trace("Execute SQL Statement finished!\n");
	   	Trace("***Programming Debug!! return!!!\n");
	   	return 0;
	} 
	$subrc = $$substh->finish;
	Trace("Execute SQL Statement finished!\n");
}
###########################################################################
# Function: SetError
# Description: execute sql statement 
# Input:  
#	1.$ErrorRollBack	Default 0
#	2.$ErrorCommit		Default 0
#	3.$ErrorExit		Default 0
#	4.$ErrorDebug		Default 1
# Output: Null
# Return: Null
###########################################################################
sub SetError
{
	$ErrorRollBack = shift;
	$ErrorCommit = shift;
	$ErrorExit = shift;
	$ErrorDebug = shift;
}
###########################################################################
# Function: Write_Dchk_Err
# Description: Write_Dchk_Err
# Input:  
#	error info
# Output: Null
# Return: Null
###########################################################################
sub Write_Dchk_Err
{
	my $err_info = shift;
	my ($sub_statement);
	my ($sub_dbh,$sub_sth,$sub_rc,$dc_ctime);
	my ($subconn_dbn,$subconn_dbd,$subconn_uid,$subconn_pwd);

	($subconn_dbd,$subconn_dbn,$subconn_uid,$subconn_pwd)=Get_ODBMS();
	
	if(!($subconn_dbd and $subconn_dbn))
	{
		($subconn_dbd,$subconn_dbn,$subconn_uid,$subconn_pwd)=Get_DBMS();
	}
	if(!($subconn_dbd and $subconn_dbn))
	{
		Trace("Warning: Not get cookdb dbms,so not write data check error information!");
		return 0;
	}

	$dc_ctime = CFtime('YYYY-MM-DD hh:mm:ss');
	Trace("Connecting Database! DBI:$subconn_dbd:$subconn_dbn $subconn_uid/*****\n");
	
	$sub_rc = $sub_dbh = DBI->connect("DBI:$subconn_dbd:$subconn_dbn",$subconn_uid,$subconn_pwd,
			{RaiseError => 0,PrintError => 0, AutoCommit => 1});
	if(!$sub_rc)
	{
		Trace("Err:Connect Database error!\nErr Info:$DBI::errstr\n");
		return 0;
	}
	
	$sub_statement =<<EOF;
INSERT INTO mapi_dchk_err
(
omc_id,			data_collect_time,
scan_start_time,	scan_stop_time,
perf_name,		err_info
)
VALUES(?,?,?,?,?,?);
EOF
	
	$sub_rc = $sub_sth = $sub_dbh->prepare($sub_statement);
	if(!$sub_rc)
	{
		Trace("Err:SQL Prepare error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
		$sub_dbh->disconnect;
		return 0;
	}
	$sub_rc = $sub_sth->execute($OMC_ID,$dc_ctime,$PM_DCHK_STIME,$PM_DCHK_ETIME,$PM_DCHK_PNAME,$err_info);
	if(!$sub_rc)
	{
		Trace("Err:Write Data Check Information Error!Err Info:".$DBI::errstr);
		$sub_dbh->disconnect;
		return 0;
	}

	$sub_sth->finish;

	$sub_rc = $sub_dbh->disconnect;
	
	Trace("Write data check information end!\n");
}
###########################################################################
# Function: Write_OlogDB
# Description: Write OlogDb
# Input:  
#	0/1/2	# start_time/end_time/error
# Output: Null
# Return: Null
###########################################################################
sub Write_OlogDB
{
	my $ss_flag = shift;
	my ($sub_statement);
	my ($sub_dbh,$sub_sth,$sub_rc);
	my ($subconn_dbn,$subconn_dbd,$subconn_uid,$subconn_pwd);

	($olog_dbd,$olog_dbn,$olog_uid,$olog_pwd)=Get_ODBMS();
	
	if(!($olog_dbd and $olog_dbn))
	{
		($olog_dbd,$olog_dbn,$olog_uid,$olog_pwd)=Get_DBMS();
	}
	if(!($olog_dbd and $olog_dbn))
	{
		Trace("Warning: Not set olog dbms,so not insert tad_instance table");
		return 0;
	}
	
	my ($seq_ins_id,$seq_ins_nextval,$curtime);
	if ($COOKDB_TYPE eq 'ORACLE')
	{
		$seq_ins_id = 'ins_id,';
		$seq_ins_nextval = 'q_tad_instance.nextval,';
	}
	$DMMMT_DCMSG_INSTANCE_START = CFtime('YYYY-MM-DD hh:mm:ss');
	Trace("Connecting Olog Database! DBI:$olog_dbd:$olog_dbn $olog_uid/*****\n");
	
	$sub_rc = $sub_dbh = DBI->connect("DBI:$olog_dbd:$olog_dbn",$olog_uid,$olog_pwd,
			{RaiseError => 0,PrintError => 0, AutoCommit => 1});
	if(!$sub_rc)
	{
		Trace("Err:Connect Ologdb Database error!\nErr Info:$DBI::errstr\n");
		return 0;
	}
	
	if ($ss_flag == 1)
	{
		Trace("Write OlogDB End!INSTANCE ID = $DMMMT_DCMSG_INSTANCE_ID\n");
		$sub_statement =<<EOF;
UPDATE tad_instance
SET end_time = '$DMMMT_DCMSG_INSTANCE_START'
WHERE ins_id = $DMMMT_DCMSG_INSTANCE_ID
EOF
		$sub_rc = $sub_sth = $sub_dbh->prepare($sub_statement);
		if(!$sub_rc)
		{
			Trace("Err:Ologdb SQL Prepare error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
			$sub_dbh->disconnect;
			return 0;
		}
		$sub_rc = $sub_sth->execute();
		if(!$sub_rc)
		{
			Trace("Err:Write Ologdb Error!Err Info:".$DBI::errstr);
			$sub_dbh->disconnect;
			return 0;
		}
		$sub_dbh->disconnect;
		return;	
	}
	if ($ss_flag == 2)
	{
		Trace("Write OlogDB Error!INSTANCE ID = $DMMMT_DCMSG_INSTANCE_ID\n");
		$sub_statement =<<EOF;
UPDATE tad_instance
SET error_num = 1
WHERE ins_id = $DMMMT_DCMSG_INSTANCE_ID
EOF
		$sub_rc = $sub_sth = $sub_dbh->prepare($sub_statement);
		if(!$sub_rc)
		{
			Trace("Err:Ologdb SQL Prepare error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
			$sub_dbh->disconnect;
			return 0;
		}
		$sub_rc = $sub_sth->execute();
		if(!$sub_rc)
		{
			Trace("Err:Write Ologdb Error!Err Info:".$DBI::errstr);
			$sub_dbh->disconnect;
			return 0;
		}
		$sub_statement =<<EOF;
INSERT INTO TABLE tad_instance_err
(ins_id,err_code,err_string)
VALUES($DMMMT_DCMSG_INSTANCE_ID,1,'Task ID: $DMMMT_DCMSG_TASK_ID Data Collection Error!')
EOF
		$sub_rc = $sub_sth = $sub_dbh->prepare($sub_statement);
		if(!$sub_rc)
		{
			Trace("Err:Ologdb SQL Prepare error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
			$sub_dbh->disconnect;
			return 0;
		}
		$sub_rc = $sub_sth->execute();
		if(!$sub_rc)
		{
			Trace("Err:Write Ologdb Error!Err Info:".$DBI::errstr);
			$sub_dbh->disconnect;
			return 0;
		}
		$sub_dbh->disconnect;
		return 0;	
	}	

	Trace("Write OlogDB\nInfo:\n\tTASK ID = $DMMMT_DCMSG_TASK_ID,rdn = $DMMMT_DCMSG_INSTANCE_RDN\n");


	$sub_statement =<<EOF;
INSERT INTO tad_instance
(
$seq_ins_id	parent_ins_id,		related_task,
object_class,	rdn,			begin_time,	error_num
)
VALUES(
$seq_ins_nextval	0,		$DMMMT_DCMSG_TASK_ID,
100,		'$DMMMT_DCMSG_INSTANCE_RDN','$DMMMT_DCMSG_INSTANCE_START',0
)
EOF
	
	$sub_rc = $sub_sth = $sub_dbh->prepare($sub_statement);
	if(!$sub_rc)
	{
		Trace("Err:Ologdb SQL Prepare error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
		$sub_dbh->disconnect;
		return 0;
	}
	$sub_rc = $sub_sth->execute();
	if(!$sub_rc)
	{
		Trace("Err:Write Ologdb Execute Error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
		$sub_dbh->disconnect;
		return 0;
	}
	$sub_statement	=<<EOF;
SELECT ins_id FROM tad_instance
WHERE related_task = $DMMMT_DCMSG_TASK_ID
AND   object_class = 100
AND   begin_time   = '$DMMMT_DCMSG_INSTANCE_START'
AND   rdn	   = '$DMMMT_DCMSG_INSTANCE_RDN'
EOF
	$sub_rc = $sub_sth = $sub_dbh->prepare($sub_statement);
	if(!$sub_rc)
	{
		Trace("Err:Ologdb SQL Prepare error!\nSQL:\n".$sub_statement."Err Info:$DBI::errstr\n");
		$sub_dbh->disconnect;
		return 0;
	}
	$sub_rc = $sub_sth->execute();
	if(!$sub_rc)
	{
		Trace("Err:Write Ologdb Error!Err Info:".$DBI::errstr);
		$sub_dbh->disconnect;
		return 0;
	}
	
	($DMMMT_DCMSG_INSTANCE_ID) = $sub_sth->fetchrow_array;
	

	$sub_sth->finish;

	$sub_rc = $sub_dbh->disconnect;
	
	Trace("Write OlogDB\n");
}

###########################################################################
# Function: Create_Tmptable_Name
# Description: Write OlogDb
# Input:  
#	1.@tablist
# Output: Null
# Return: @tablist
# Arth:
#	'TMP' + Time(MMDDhhmmss) + ProcssID(2 bit) + serial(3 bit)
#	=>
#	first 3 bit + latest 12 bit
###########################################################################

sub Create_Tmptable_Name
{
	my (@tablist,$list_num,$i,$tabname,$timeflag,$len,$procs_id);

	my ($timeflag);
	$list_num = @_;

	$procs_id = $$;

	$timeflag = CFtime("Dhhmmss");
	if (length($procs_id) > 1)
	{
		$procs_id = substr($procs_id,$len - 2,2);
	}
	else
	{
		$procs_id = '0'.$procs_id;
	}
	for($i=1;$i<=$list_num;$i++)
	{
		if ($TmpTabTimes < 100)
		{
			if($TmpTabTimes =~/^0*(\d+)$/)
			{
				$TmpTabTimes = $1;
			}
			if($TmpTabTimes < 10)
			{
				$TmpTabTimes = "00".$TmpTabTimes;
			}
			elsif($TmpTabTimes < 100)
			{
				$TmpTabTimes = "0".$TmpTabTimes;
			}
		}
		$len = length($procs_id);
		$tabname = "TMP".$timeflag.$procs_id.$TmpTabTimes;
		$len = length($tabname);
		if ($len > 15)
		{
			$tabname = substr($tabname,0,3).substr($tabname,$len - 12,12);
		}
		@tablist = (@tablist,$tabname);
		$TmpTabTimes++;
	
	}
	return @tablist;
}

###########################################################################
# Function: Get_Column_List
# Description: Get Mapping File Information
# Input:  
#	1.$mapfile
#	2.$mark
#	3.$label	--"ALL||A[0]" "A[0]||!A[0]"  "||" => or "&&" => and "!" => not
#	4.$format	--"An"	such as "a.A[1]	A[2],"
#	5.$end_comma	--end with comma?
# Output: Null
# Return: string
###########################################################################
sub Get_Column_List
{
	my ($mapfile,$mark,$label,$rformat,$part,$end_comma,@parts,@labs);
	my ($iniline,$sub_rc,$lab_flag,$par);
	my ($result,@words,$pattern);
	my ($i,$flag,$j);
	
	$mapfile 	= shift;
	$mark 		= shift;
	$label 		= shift;
	$rformat 	= shift;
	$end_comma 	= shift;

	if ($DeBug)
	{
		Trace("Function Get_Column_List:\n\tFile:\t$mapfile\n\tMark:\t$mark\n\tLabel:\t$label\n\tFormat:\t$rformat\n\tEnd Comma:\t$end_comma");
	}
	
	$rformat =~ s/A\[/\@words\[/g;
	$rformat = "\"".$rformat."\"";
	
	if (!$label)
	{
		Trace("Err : Can not get label information!");
		return undef;
		exit 0;
	}
	
	if(!open(MAPF,$mapfile))
	{
		Trace("Err : Can not open mapping map file -- \$mapfile = $mapfile.\n");
		exit 0;
	}
	$sub_rc = 0;
	$pattern = "[\\t]+";
	
	while($iniline=<MAPF>)
	{
		$iniline = Trim($iniline);
		$part = $label;
		if($iniline =~ /^\s*$/)
		{
			next;
		}
		if ($iniline =~ /^\[\s*$mark\s*\]$/i)
		{
			$sub_rc = 1;
			$lab_flag = 1;
			next;
		}
		if ($sub_rc == 0)
		{
			next;
		}
		if ($sub_rc == 1)
		{
			if($iniline =~ /^\[\s*.+\s*\]$/)
			{
				$sub_rc = 0;
				last;
			}
			if($iniline =~ /^\s*#!(.*)/)
			{
				$iniline = $1;
		    		@labs = split(/$pattern/, $iniline);
				for($i=0;$i<@labs;$i++)
				{
					$rformat =~ s/\[@labs[$i]\]/\[$i\]/g;
				}
#说明：用于那种找不到匹配的替换为空值。例如：A[Column] 如果没有column列替换成A[100]。即：空值
				$rformat =~ s/\[[A-Za-z][_0-9a-zA-Z]*\]/\[100\]/g;
				next;
			}
			if($iniline =~ /^\s*#/)
			{
				next;
			}
		
	    		@words = split(/$pattern/, $iniline);
	    		for($i=0;$i<@words;$i++)
	    		{
	    			@words[$i] = Trim(@words[$i]);
	    		}

	    		@parts = split(/\|/,@words[0]);
	    		
	    		$flag = 0;
			
	    		for($i=0;$i<@parts;$i++)
	    		{
	    			$par = @parts[$i];
	    			$part =~ s/\b$par\b/\$/ig;
	    		}
	    		$part =~ s/\bALL\b/\$/ig;
	    		$part =~ s/\w+/0/g;
	    		$part =~ s/\$/1/g;
			#print $part."\n";
	    		$flag = eval($part);
	    		if (!$flag)
	    		{
	    			next;
	    		}
			$result = $result.eval($rformat)."\n";
			
		}
	}	
	close(MAPF);
	if ($lab_flag != 1)
	{
		Trace "Warnning:Can not find mapping file mark \[$mark\]!";
		return "";
	}
	if ($end_comma == 1)
	{
		return $result;
	}
	else
	{
		Trim($result);
		chomp($result);
		chop($result);
		return $result;
	}
	
}


###########################################################################
# Function: Debug
# Description: Debuy Shell
# Input:  
#	1.$dbh_pointer
# Output: Null
# Return: Null
###########################################################################
sub Debug
{
	my ($dbg_dbh,$dbg_sth,$dbg_statement,$sinput,@sqlresult,$coldata,$dbg_rv);
	my ($field_num,$fi,@cols,$len,$eqsym,$sv_flag,$savefilename);
	$dbg_dbh = shift;
	$dbg_sth = shift;
until(0)
{
	print "\nDEBUG==>What do you want to do? (C)ontinue/(S)QL/(E)val/(Q)uit\nDEBUG==>Please Enter:";
	STDOUT->autoflush(1);
	STDIN->autoflush(1);
	$dbg_statement = <STDIN>;
	chomp($dbg_statement);
	if ($dbg_statement eq "c" or $dbg_statement eq "C")
	{
		return;
	}
	if ($dbg_statement eq "q" or $dbg_statement eq "Q" or $dbg_statement eq "quit")
	{
		$$dbg_dbh->disconnect;
		exit 0;
	}	
	if ($dbg_statement eq "S" or $dbg_statement eq "s")
	{
		print "DEBUG-SQL==>You can execute any SQL statement and \"(q)uit\" to return.\n";
		until(0)
		{
			$dbg_statement = "";
			until(0)
			{
				print "DEBUG-SQL==>";
				STDOUT->autoflush(1);
				STDIN->autoflush(1);
				$sinput = <STDIN>;
				chomp($sinput);
				if ($sinput eq "go" or $sinput eq "GO")
				{
					last;
				}
				if ($sinput =~ /^\s*go\W+w\s+(.*)$/i)
				{
					$sv_flag = 1;
					$savefilename = $1;
					$savefilename = Trim($savefilename);
					last;
				}
				if ($sinput eq "/sql_info")
				{
					&Sql_Info($dbg_dbh,$dbg_statement,1);
					$dbg_statement = "";
					last;
				}
				if ($sinput =~ /\/tab_info\s+(.*)/)
				{
					&Sql_Info($dbg_dbh,$1);
					$dbg_statement = "";
					last;
				}				
				if ($sinput eq "q" or $sinput eq "Q" or $sinput eq "quit")
				{
					$dbg_statement = $sinput;
					last;
				}
				if ($sinput eq "clear" or $sinput eq "CLEAR")
				{
					$dbg_statement = "";
					next;
				}
				if ($sinput eq "echo" or $sinput eq "ECHO")
				{
					print $dbg_statement."\n";
					next;
				}
				$dbg_statement = $dbg_statement."\n".$sinput;
			}
			if($dbg_statement eq "q" or $dbg_statement eq "Q" or $dbg_statement eq "quit")
			{
				last;
			}	
			if($dbg_statement eq "")
			{
				next;
			}
			if($dbg_statement !~ /^\s*select/i)
			{
				$dbg_rv = $$dbg_dbh->do($dbg_statement);
				if(!$dbg_rv)
				{
					print "\nErr:".$DBI::errstr."\n";
					next;
				}
				else
				{
					print "\n=========================\n$dbg_rv Rows be touched\n=========================\n";
					next;
				}			
			}
			if(!($dbg_sth = $$dbg_dbh->prepare($dbg_statement)))
			{
				print "\nErr:".$DBI::errstr."\n";
				next;
			}
			
			$dbg_rv = $dbg_sth->execute();
			if(!$dbg_rv)
			{
				print "\nErr:".$DBI::errstr."\n";
				next;
			}
			$len = 0;
			$dbg_rv = 0;
			$field_num = $dbg_sth->{NUM_OF_FIELDS};
			for ($fi=0;$fi<$field_num;$fi++)
			{
				
				@cols[$fi] = $dbg_sth->{NAME}->[$fi];
				$len = $len + length(@cols[$fi]."\t");
				print "@cols[$fi]\t";
			}
			$eqsym = "=";
			$eqsym x= $len;
			print "\n$eqsym\n";
			#$fi,@cols
			if ($sv_flag == 1)
			{
				open(DATAFILE,">".$savefilename)||die "open file error!\n";
				
			}
			while(@sqlresult = $dbg_sth->fetchrow_array)
			{
				foreach my $coldata(@sqlresult) 
				{
				    print $coldata."\t";
				    if ($sv_flag == 1)
				    {
				    	print DATAFILE $coldata."\|";
				    }
				}
				$dbg_rv ++;
				print "\n";
				if ($sv_flag == 1)
				{
				 	print DATAFILE "\n";
				}
			}
			print "$eqsym\n";
			print "Return $field_num colums and $dbg_rv lines\n";
			if ($sv_flag == 1)
			{
				close(DATAFILE);
				$sv_flag = 0;
				print "All write to file $savefilename\n";
				$savefilename = "";
			}
			$dbg_sth->finish;
		}
		next;
	}
	if ($dbg_statement eq "E" or $dbg_statement eq "e")
	{
		print "DEBUG-EVAL==>You can execute any perl statement and \"(q)uit\" to return.\n";
		until(0)
		{
			print "DEBUG-EVAL==>";
			STDOUT->autoflush(1);
			STDIN->autoflush(1);
			$dbg_statement = <STDIN>;
			chomp($dbg_statement);
			if($dbg_statement eq "q" or $dbg_statement eq "Q" or $dbg_statement eq "quit")
			{
				last;
			}	
			if($dbg_statement eq "")
			{
				next;
			}
			print $dbg_statement."\n";
			eval($dbg_statement);
			print "\n";
		}
		next;			
	}	
}
$$dbg_dbh->disconnect;
}
###########################################################################
# Function: Get_DBMS
# Description: Get_DBMS
# Input:  Null
# Output: Null
# Return: Null
###########################################################################
sub Get_DBMS	
{
	return ($conn_dbd,$conn_dbn,$conn_uid,$conn_pwd,$conn_mark);	
}
###########################################################################
# Function: Set_DBMS
# Description: Set_DBMS
# Input:  
#	1.$mark
# Output: Null
# Return: Null
###########################################################################
sub Set_DBMS	
{
	my $mark = shift;
	$conn_mark = $mark;
	if($CONFIG_IN_LDAP)
	{
		($conn_dbd,$conn_dbn,$conn_uid,$conn_pwd) = NPM_Get_DBMS_From_LDAP($mark);
	}
	else
	{
		($conn_dbd,$conn_dbn,$conn_uid,$conn_pwd) = Get_DBMS_From_File($MapiFile,$mark);
	}
	if ($PwdEncrypt)
	{
		$conn_pwd = Pwd_Decrypt($conn_pwd);
	}
	if($DeBug)
	{
   		Trace("Set_DBMS\($conn_mark\)\n\tCONN_DBD\t=\t$conn_dbd\n\tCONN_DBN\t=\t$conn_dbn\n\tCONN_UID\t=\t$conn_uid\n\tCONN_PWD\t=\t$conn_pwd");
	}
}
###########################################################################
# Function: Get_ODBMS
# Description: Get_ODBMS
# Input:  Null
# Output: Null
# Return: Null
###########################################################################
sub Get_ODBMS	
{
	return ($olog_dbd,$olog_dbn,$olog_uid,$olog_pwd);	
}
###########################################################################
# Function: Set_ODBMS
# Description: Set_ODBMS
# Input:  
# Output: Null
# Return: Null
###########################################################################
sub Set_ODBMS	
{
	$olog_dns = shift;
	if($CONFIG_IN_LDAP)
	{
		($olog_dbd,$olog_dbn,$olog_uid,$olog_pwd)=NPM_Get_DBMS_From_LDAP($olog_dns,"dsn");
	}
	else
	{
		($olog_dbd,$olog_dbn,$olog_uid,$olog_pwd)=Get_DBMS_From_File($MapiFile,$olog_dns);
	}
	if ($PwdEncrypt and $olog_pwd)
	{
		$olog_pwd = Pwd_Decrypt($olog_pwd);
	}	
	$olog_dbd   	= $conn_dbd 	if(!defined($olog_dbd));
	$olog_dbn   	= $conn_dbn 	if(!defined($olog_dbn));
	$olog_uid   	= $conn_uid 	if(!defined($olog_uid));
	$olog_pwd   	= $conn_pwd 	if(!defined($olog_pwd));

}
###########################################################################
# Function: Get_DBMS_From_File
# Description: Get_DBMS_From_File
# Input:  
#	1.$filename	[MARK]
#			CONN_DBN = 
#			CONN_DBD = 
#			CONN_UID = 
#			CONN_PWD = 
#	2.mark		[MARK]
# Output: Null
# Return: $sub_dbn,$sub_dbd,$sub_uid,$sub_pwd
###########################################################################
sub Get_DBMS_From_File
{
	my ($mname,$subfilename);
	my ($sub_dbn,$sub_dbd,$sub_uid,$sub_pwd);
	
	$subfilename = shift;
	$mname = shift;
	my $dbn_lab="CONN_DBN";
	my $dbd_lab="CONN_DBD";
	my $uid_lab="CONN_UID";
	my $pwd_lab="CONN_PWD";
	my $file_ref = Read_IniFile($subfilename);
	return ($file_ref->{$mname}->{$dbd_lab},$file_ref->{$mname}->{$dbn_lab},$file_ref->{$mname}->{$uid_lab},$file_ref->{$mname}->{$pwd_lab});
}

###########################################################################
# Function: Get_ObjClass_by_NeName
# Description: Get_ObjClass_by_NeName
# Input:  
#	1.NeName
# Output: Null
# Return: Object class
###########################################################################
sub Get_ObjClass_by_NeName
{
	my $NeName = shift;
	$NeName = uc($NeName);
	return $COOKDB_OBJECT_CLASS{$NeName};
}
###########################################################################
# Function: Read_IniFile
# Description: Read_IniFile
# Input:  Ini file
# Output: Null
# Return: file content pointer
###########################################################################
sub Read_IniFile
{
	my ($file_ref,$fs,$mname,$mifile,$shead,$sdef);
	#$mifile = $MapiFile;	
	$mifile = shift;
	if (not -e $mifile)
	{
		Trace("Err:File Not Found - $mifile\n");
		return;
	}
	$fs = open(SF,$mifile);
	if (not $fs)
	{
		Trace "Err:Can not open file $mifile!\n";
		return -1;
	}
	$fs = 0;
	while(<SF>)
	{
		my $line = Trim($_);
		if ($line eq "" )
		{
			next;
		}

		if($line =~ /^#.*/) 	# if comments line #
		{
			next;
		}
		if($line =~ /^\[(.*)\]\s*$/)
		{
			$mname = $1;
			if ($fs == 0)
			{
				$fs = 1;
			}
			next;
		}

		if ($fs == 1)
		{
			($shead,$sdef) = split(/=/, $line,2);
			$shead = Trim($shead);
			$sdef = Trim($sdef);
			$file_ref->{$mname}->{$shead} = $sdef;
		}
	}
	close(SF);
	return $file_ref;	
}
###########################################################################
# Function: Init_Variable
# Description: Init_Variable
# Input:  $module
# Output: Null
# Return: all variable with value
###########################################################################
sub Init_Variable
{
	my ($key,$evl,$value);
	my $module = shift;
	my $mapifile_ref = Read_IniFile($MapiFile);
	foreach $key (keys %{$mapifile_ref->{"GLOBAL"}})
	{
		$value = $mapifile_ref->{"GLOBAL"}->{$key};
		$evl .= "\$$key = \"$value\";\n";
		#eval($evl);
		
	}
	foreach $key (keys %{$mapifile_ref->{$module}})
	{
		$value = $mapifile_ref->{$module}->{$key};
		$evl .= "\$$key = \"$value\";\n";
		#print "$evl\n";
		#eval($evl);
		#print $VENDORNAME."\n";
	}
	#print "$evl\n";
	return $evl;	
}
###########################################################################
# Function: Init_Varhash
# Description: Init Variable to Hash
# Input:  $module
# Output: Null
# Return: Hash which keys is varibles' name
###########################################################################
sub Init_Varhash
{
	my ($key, $value, %hash);
	my $module = shift;
	my $mapifile_ref = Read_IniFile($MapiFile);
	foreach $key (keys %{$mapifile_ref->{"GLOBAL"}})
	{
		$value = $mapifile_ref->{"GLOBAL"}->{$key};
		$value =~ s/(\$\w+)/$hash{$1}/g;
		$key = '$'.$key;
		$hash{$key} = $value;
	}
	foreach $key (keys %{$mapifile_ref->{$module}})
	{
		$value = $mapifile_ref->{$module}->{$key};
		$value =~ s/(\$\w+)/$hash{$1}/g;
		$key = '$'.$key;
		$hash{$key} = $value;
	}
	return %hash;
}
###########################################################################
# Function: niExec
# Description: Excute command
# Input:  $command,$timeout,$retrys,$sleep
# Output: Null
# Return: command return value
###########################################################################
sub niExec {
	my $command = shift; # Command to run
	my $timeout = shift; # Set time out
	my $retrys  = shift; # Retry times when time out
	my $sleep   = shift; # Time for waitting between retrys

	my $rtn;             # Return value for run the command
	$timeout = 60 if (! $timeout);
	$sleep   = 1  if (! $sleep);
	$SIG{'ALRM'} = sub { die "timeout\n"; };

	while(1) 
	{
		#Trace "Exec command:\n\t$command\n";
		if ($command =~ /^\s*cd\s+(\S.*)/)
		{
			$rtn = chdir($1)? 0:1;
			last;
		}
		eval 
		{
			alarm($timeout);
			$rtn = system($command);
			alarm(0);
		};
		last if ($@ !~ /timeout/); 
		if (!$retrys) {
			$rtn = -1;
			last;
		}
		Trace "Execute $command time out\nWait for retry ...\n";
		$retrys --;
		sleep($sleep);
	}
	if (!$rtn)
	{
		Trace "Exec command success!\n";
	}
	else
	{
		Trace "Exec command failed: $rtn\n";
	}
	return $rtn;
}
###########################################################################
# Function: Read_MapIniFile
# Description: Read_MapIniFile
# Input:  Null
# Output: Null
# Return: file content pointer
###########################################################################
sub Read_MapIniFile
{
	my $mapifile_ref;
	$mapifile_ref = Read_IniFile($MapiFile);
	return $mapifile_ref;
}
###########################################################################
# Function: hex2spc
# Description: hex2spc
# Input:  hex
# Output: Null
# Return: spc
###########################################################################
sub Hex2spc
{
	my $spc = shift;
	my $spc = Bin2spc(Hex2bin($spc));
	return $spc;
}

###########################################################################
# Function: int2spc
# Description: hex2spc
# Input:  hex
# Output: Null
# Return: spc
###########################################################################
sub Int2spc
{
	my $spc = shift;
	my $spc = Bin2spc(Int2bin($spc));
	return $spc;
}

###########################################################################
# Function: int2spc
# Description: hex2spc
# Input:  hex
# Output: Null
# Return: spc
###########################################################################
sub Bin2spc
{
	my $binnum = shift;
	my $spc;
	my $len = length($binnum);
	if ($len > 14)
	{
		$spc = Bin2int(substr($binnum,0,$len-16)).".".
		       Bin2int(substr($binnum,$len-16,8)).".".
		       Bin2int(substr($binnum,$len-8,8));		
	}
	else
	{
		$spc = Bin2int(substr($binnum,0,$len-7)).".".
		       Bin2int(substr($binnum,$len-7,7));
	}
}

###########################################################################
# Function: Int2bin
# Description: Int2bin
# Input:  int num
# Output: Null
# Return: bin num
###########################################################################
sub Int2bin
{
	my $intnum = shift;
	my ($binnum,$bi);
	my $len = length($intnum);
	while ($intnum > 0)
	{
		$bi = $intnum - int($intnum/2)*2;
		$intnum = int($intnum/2);
		$binnum = $bi.$binnum;
	}
	return $binnum;
}
###########################################################################
# Function: hex2bin
# Description: hex2bin
# Input:  hex
# Output: Null
# Return: bin
###########################################################################
sub Hex2bin
{
	my $hexnum = shift;
	my $binnum = Int2bin(Hex2int($hexnum));
	return $binnum;
}

###########################################################################
# Function: Bin2int
# Description: Bin2int
# Input:  bin num
# Output: Null
# Return: int num
###########################################################################

sub Bin2int
{
	my $binum = shift;
	my $intnum;
	my $len = length($binum);
	for (my $i = 0;$i<$len;$i++)
	{
		$intnum += substr($binum,$i,1)*2**($len-$i-1);
	}
	return $intnum;
}
###########################################################################
# Function: Int2hex
# Description: Int2hex
# Input:  int num
# Output: Null
# Return: hex num
###########################################################################

sub Int2hex
{
	my $intnum = shift;
	my ($hexnum,$bi);

	while ($intnum > 1)
	{
		$bi = $intnum - int($intnum/16)*16;
		if ($bi == 10)
		{
			$bi = 'A';
		}
		elsif($bi == 11)
		{
			$bi = 'B';
		}
		elsif($bi == 12)
		{
			$bi = 'C';
		}
		elsif($bi == 13)
		{
			$bi = 'D';
		}
		elsif($bi == 14)
		{
			$bi = 'E';
		}
		elsif($bi == 15)
		{
			$bi = 'F';
		}								
		$intnum = int($intnum/16);
		$hexnum = $bi.$hexnum;
	}
	return $hexnum;	
}

###########################################################################
# Function: Hex2int
# Description: Hex2int
# Input:  int num
# Output: Null
# Return: hex num
###########################################################################

sub Hex2int
{
	my $hexnum = shift;
	my ($intnum,$bi);

	my $intnum;
	my $len = length($hexnum);
	for (my $i = 0;$i<$len;$i++)
	{
		$bi = substr($hexnum,$i,1);
		if ($bi eq 'A' or $bi eq 'a')
		{
			$bi = 10;
		}
		elsif($bi eq 'B' or $bi eq 'b')
		{
			$bi = 11;
		}
		elsif($bi eq 'C' or $bi eq 'c')
		{
			$bi = 12;
		}
		elsif($bi eq 'D' or $bi eq 'd')
		{
			$bi = 13;
		}
		elsif($bi eq 'E' or $bi eq 'e')
		{
			$bi = 14;
		}
		elsif($bi eq 'F' or $bi eq 'f')
		{
			$bi = 15;
		}
		elsif($bi !~ /\d/)
		{
			$bi = 0;
		}
		$intnum += $bi*16**($len-$i-1);
	}
	return $intnum;
}
###########################################################################
# Function: Sql_Info
# Description: Sql_Info
# Input:  
#	1.dbh poition
#	2.sql statement
#	3.print flag
# Output: Null
# Return: SQL Info num
###########################################################################

sub Sql_Info
{
	my ($sub_statement,$sub_sth,$sub_sql,$sub_info,$sub_flag,$sub_dbh);
	my ($i,$fields,$colname,$nullable,$coltype,$colprec,$colscale);
	$sub_dbh = shift;
	$sub_statement = shift;
	$sub_flag = shift;

	if (!($sub_sth = $$sub_dbh->prepare($sub_statement)))
	{
		print "\nErr:SQL statement prepare ".$sub_statement."\nErr Info:".$DBI::errstr."\n";
		return;
	}
	if (!($sub_sth->execute))
	{
		print "\nErr:SQL statement execute ".$sub_statement."\n";
		return;
	}	
	
	$fields = $sub_sth->{NUM_OF_FIELDS};
	if ($sub_flag == 1)
	{
		print "Column Name	    Type                           Precision  Scale    Nullable\n";
		print "================================================================================\n";
	}
	for($i=0;$i<$fields;$i++)
	{
		$colname = $sub_sth->{NAME}->[$i];
		$nullable = ("No","Yes","Unknown") [$sub_sth->{NULLABLE}->[$i]];
		$colscale = $sub_sth->{SCALE}->[$i];
		$colprec = $sub_sth->{PRECISION}->[$i];
#		$coltype = $sub_sth->{TYPE}->[$i];
#		($coltype) = map(scalar $$sub_dbh->type_info($_)->{TYPE_NAME},($sub_sth->{TYPE}->[$i]));
		$coltype = $SQL_TYPE_INFO->{$COOKDB_TYPE}->{$sub_sth->{TYPE}->[$i]};
		if ($sub_flag == 1)
		{
			printf "%-20s %-30s %4d      %4d    %s\n",$colname,$coltype,$colprec,$colscale,$nullable;
		}
		if($sub_sth->{TYPE}->[$i] == 1)
		{
			$sub_sql = $sub_sql.$colname."\t".$coltype."(".$colprec."),\n";
		}
		elsif($sub_sth->{TYPE}->[$i] == 3 or $sub_sth->{TYPE}->[$i] == 12)
		{
			$sub_sql = $sub_sql.$colname."\t".$coltype."(".$colprec.",".$colscale."),\n";
		}
		else
		{
			$sub_sql = $sub_sql.$colname."\t".$coltype.",\n";
		}
	}
	if ($sub_flag == 1)
	{
		print "================================================================================\n";
	}
	chomp($sub_sql);
	chop($sub_sql);
	return $sub_sql;
}

###########################################################################
# Function: Tab_Info
# Description: Tab_Info
# Input:  
#	1.dbh poition
#	2.tab name
# Output: Null
# Return: Null
###########################################################################

sub Tab_Info
{
	my ($sub_sth,$sub_sth,$sub_sql,$sub_info,$sub_tab,$sub_dbh);
	my ($i,$fields,$colname,$nullable,$coltype,$colprec,$colscale);
	$sub_dbh = shift;
	$sub_tab = shift;
	
	if ($sub_tab eq "")
	{
		print "\nErr:Null table name\n";
		return;	
	}
	$sub_sql = "select * from ".$sub_tab;
	if (!($sub_sth = $$sub_dbh->prepare($sub_sql)))
	{
		print "\nErr:Table ".$sub_tab."\nErr Info:".$DBI::errstr."\n";
		return;
	}
	if (!($sub_sth->execute))
	{
		print "\nErr:Table ".$sub_tab."\n";
		return;
	}	
	$fields = $sub_sth->{NUM_OF_FIELDS};
	print "Column Name	    Type                           Precision  Scale    Nullable\n";
	print "================================================================================\n";
	for($i=0;$i<$fields;$i++)
	{
		$colname = $sub_sth->{NAME}->[$i];
		$nullable = ("No","Yes","Unknown") [$sub_sth->{NULLABLE}->[$i]];
		$colscale = $sub_sth->{SCALE}->[$i];
		$colprec = $sub_sth->{PRECISION}->[$i];
		$coltype = $sub_sth->{TYPE}->[$i];
		($coltype) = map(scalar $$sub_dbh->type_info($_)->{TYPE_NAME},($sub_sth->{TYPE}->[$i]));
		printf "%-20s %-30s %4d      %4d    %s\n",$colname,$coltype,$colprec,$colscale,$nullable;
	}
	print "================================================================================\n";
	
	$sub_sth->finish;
}

###########################################################################
# Function: Replace_SQL_Standard_Type
# Description: Tab_Info
# Input:  
#	1.string
# Output: Null
# Return: String
###########################################################################

sub Replace_SQL_Standard_Type
{
	my $string = shift;
	my ($key,$value,$type);
	foreach $key (keys(%SQL_STANDARD_TYPE_NUM)) 
	{
		$value = $SQL_STANDARD_TYPE_NUM{$key};
		$type = $SQL_TYPE_INFO->{$COOKDB_TYPE}->{$value};
		$string =~ s/\b$key\b/$type/ig;
	}
	return $string;
}

###########################################################################
# Function: Replace_SQL_Standard_Type
# Description: Tab_Info
# Input:  
#	1.string
# Output: Null
# Return: String
###########################################################################

sub Replace_SQL_Standard2Database_Type
{
	my $string = shift;
	my ($key,$value,$type);
	if($COOKDB_TYPE eq "INFORMIX")
	{
		foreach $key (keys(%SQL_STANDARD_TYPE_NUM)) 
		{
			$value = $SQL_STANDARD_TYPE_NUM{$key};
			$type = $SQL_TYPE_INFORMIX{$value};
			$string =~ s/\b$key\b/$type/ig;
		}			
	}
	if($COOKDB_TYPE eq "ORACLE")
	{
		foreach $key (keys(%SQL_STANDARD_TYPE_NUM)) 
		{
			$value = $SQL_STANDARD_TYPE_NUM{$key};
			$type = $SQL_TYPE_ORACLE{$value};
			$string =~ s/\b$key\b/$type/ig;
		}			
	}
	return $string;
}


###########################################################################
# Function: Net_Ftp_Connect
# Description: Net_Ftp_Connect
# Input:  
#	1.host
#	2.uid
#	3.pwd
# Output: Null
# Return: Null
###########################################################################

sub Net_Ftp_Connect
{
	my $host = shift;
	my $ftp_usr = shift;
	my $ftp_pwd = shift;
	Trace ("Connected to $host.\n",0);
	if(!($net_ftp = Net::FTP->new($host,Timeout=>$NetTimeout,Debug=>0)))
	{
		Trace ("Err: Net::FTP can't connect $host: $@\n",0);
		return 0;
	}

	Trace ("\nLogin:$ftp_usr \nPassword:*****\n",0);
	if(!($net_ftp->login($ftp_usr,$ftp_pwd)))
	{
		Trace ("Err: Net::FTP couldn't authenticate, even with explicit username and password.\n",0);
	}
	else
	{
		Trace ("Net::FTP connect $host successful!\n",0);
	}
}

###########################################################################
# Function: Net_Ftp_Disconnect
# Description: Net_Ftp_Disconnect
# Input:  Null
# Output: Null
# Return: Null
###########################################################################

sub Net_Ftp_Disconnect
{
	if(defined($net_ftp))
	{
		$net_ftp->quit();
		Trace ("Net::FTP diconnect!\n",0);
	}
	else
	{
		Trace ("Warning Net::FTP have not connected!\n",0);
	}
}

###########################################################################
# Function: Net_Ftp_Get
# Description: Net_Ftp_Get
# Input:  
#	1.file
#	2.remote dir
#	3.local dir
# Output: Null
# Return: Null
###########################################################################

sub Net_Ftp_Get
{
	my $getfile =shift;
	my $local_dir = shift;
	my $remote_dir = shift;
	my ($remote_file, $local_file);
	
	if ($getfile =~ /^\s*$/)
	{
		Trace ("Err: Net::FTP get file is null!\n",0);
	}
	if ($remote_dir =~ /^\s*$/)
	{
		$remote_file = $getfile;
	}
	elsif ($remote_dir =~ /\/$/)
	{
		$remote_file = $remote_dir.$getfile;
	}
	else
	{
		$remote_file = $remote_dir.'/'.$getfile;	
	}
	
	
	if ($local_dir =~ /^\s*$/)
	{
		$local_file = $getfile;
	}
	elsif ($local_dir =~ /\/$/)
	{
		$local_file = $local_dir.$getfile;
	}
	else
	{
		$local_file = $local_dir.'/'.$getfile;	
	}	
	if(defined($net_ftp))
	{
		Trace ("\nGet File to local host $local_file from remote $remote_file\n",0);
		$net_ftp->get($remote_file,$local_file) || die "Cannot get $remote_file : $!\n";
	}
	else
	{
		Trace ("Warning Net::FTP have not connected!\n",0);
	}
}


###########################################################################
# Function: Net_Ftp_Put
# Description: Net_Ftp_Put
# Input:  
#	1.file
#	2.remote dir
#	3.local dir
# Output: Null
# Return: Null
###########################################################################

sub Net_Ftp_Put
{
	my $putfile =shift;
	my $local_dir = shift;
	my $remote_dir = shift;
	my ($remote_file, $local_file);
	
	if ($putfile =~ /^\s*$/)
	{
		Trace ("Err: Net::FTP get file is null!\n",0);
	}
	if ($remote_dir =~ /^\s*$/)
	{
		$remote_file = $putfile;
	}
	elsif ($remote_dir =~ /\/$/)
	{
		$remote_file = $remote_dir.$putfile;
	}
	else
	{
		$remote_file = $remote_dir.'/'.$putfile;	
	}
	
	
	if ($local_dir =~ /^\s*$/)
	{
		$local_file = $putfile;
	}
	elsif ($local_dir =~ /\/$/)
	{
		$local_file = $local_dir.$putfile;
	}
	else
	{
		$local_file = $local_dir.'/'.$putfile;	
	}	
	if(defined($net_ftp))
	{
		Trace ("\nPut File local host $local_file to remote $remote_file\n",0);
		$net_ftp->put($local_file, $remote_file) || die "Can't put $local_file : $!\n";
	}
	else
	{
		Trace ("Warning Net::FTP have not connected!\n",0);
	}
}

###########################################################################
# Function: Net_Telnet_Connect
# Description: Net_Telnet_Connect
# Input:  
#	1.host
#	2.uid
#	3.pwd
# Output: Null
# Return: Null
###########################################################################

sub Net_Telnet_Connect
{
	my $host = shift;
	my $telnet_usr = shift;
	my $telnet_pwd = shift;
	Trace ("Telet connected to $host.\n",0);
	$net_telnet = new Net::Telnet (Timeout => $NetTimeout,
	                     Prompt => '/[%#>] $/');
	
	if(!($net_telnet->open($host)))
	{
		Trace ("Err: Net::Telnet can't connect $host: $@\n",0);
		return -1;
	}
	Trace ("\nLogin:$telnet_usr \nPassword:*****\n",0);	

	if(!($net_telnet->login($telnet_usr, $telnet_pwd)))
	{
		Trace ("Err: Net::Telnet couldn't authenticate, even with explicit username and password.\n",0);
	}
	else
	{
		Trace ("Net::Telnet connect $host successful!\n",0);
	}
	Trace ("Net::Telnet set remote hosts prompt \"$net_prompt\"!\n",0);
	$net_telnet->prompt("/$net_prompt\$/");
	$net_telnet->cmd("set prompt = '$net_prompt'");	
}

###########################################################################
# Function: Net_Telnet_Disconnect
# Description: Net_Telnet_Disconnect
# Input:  Null
# Output: Null
# Return: Null
###########################################################################

sub Net_Telnet_Disconnect
{
	if(defined($net_telnet))
	{
		$net_telnet->close;
		Trace ("Net::Telnet diconnect!\n",0);
	}
	else
	{
		Trace ("Warning Net::Telnet have not connected!\n",0);
	}
}

###########################################################################
# Function: Net_Telnet_Cmd
# Description: Net_Telnet_Cmd
# Input:  $cmd,$ref,$secs
# Output: Null
# Return: Null
###########################################################################

sub Net_Telnet_Cmd
{
	my $cmd 	= shift;
	my $ouput_ref 	= shift;
	my $secs 	= shift;
	my  @output;
	if (!$secs)
	{
		$secs = $NetTimeout;
	}

	if(defined($net_telnet))
	{
		Trace ("Command:$cmd\n",0);
   		@output = $net_telnet->cmd(
   				String  => $cmd,
				Output  => $ouput_ref,
                        	Timeout => $secs);
		Trace ("Net::Telnet command execute finished!\n",0);
		return @output;
	}
	else
	{
		Trace ("Warning Net::Telnet have not connected!\n",0);
		return -1;
	}

}
###########################################################################
# Function: Touch_Dir
# Description: Touch_Dir
# Input:  $Touch_Dir
# Output: Null
# Return: Null
###########################################################################

sub Touch_Dir
{
    my $touch_dir = shift;
    my (@touch_subdir,$sub_dir,$fetchdir);
    if (-e $touch_dir && -d $touch_dir)
    {
	unless (-w $touch_dir)
	{
	    print "Err: Write trace failed because of $^E\n";
	    exit 0;
	}
    }
    else
    {
	@touch_subdir = split (/\//,$touch_dir);
	foreach $sub_dir (@touch_subdir)
	{
	    if ($sub_dir)
	    {
	        $fetchdir = $fetchdir."/".$sub_dir;
	    	if (!-e $fetchdir)
	    	{
	    	    my $result;
		    unless ($result = mkdir($fetchdir,0755))
		    {
	    		print "Err: Create trace directory --$fetchdir failed because of $^E\n";
	    		exit 0;
        	    }
		}
	    }
	}   	
    }
}

###########################################################################
#                                                                         #
#                         sub Send_Msg()                           	  #
#                                                                         #
###########################################################################
sub Send_Msg
#Parameter: 1.port_id 2.ODBCDSN 3.MsgTableName 4.MsgType 5.MsgSort(0-Dal 1-SNMP)
{

	my $msg_port_id = shift;
	my $dsn = shift;
	my $MsgTableName = shift;
	my $MsgType = shift;
	my $MsgSort = shift;
		
#	if(uc($subconn_dbd) eq "INFORMIX")
#	{
#		$dsn = "cookdb";
#	}
	Trace "Msg_Port_id:\t$msg_port_id\n";
	Trace ("Msg_Type:\t$MsgType\n",0);
	Trace ("Log_File:\tmessage_$MsgTableName.log\n",0);
        my $SndMsgCmd = "msgtool s $msg_port_id $dsn $MsgTableName $MsgType $MsgSort message_$MsgTableName.log";
        Trace ("Command:\t$SndMsgCmd\n",0);
        my $rc = `$SndMsgCmd`;
       	Trace $rc;
        if($?)
	{
       		Trace "Send message in $MsgTableName for $msg_port_id port fault\n";
	}else
	{
		Trace "Send message OK!\n";
	}
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Function Name:	MQSend
#Date:			2002-06-04
#Description:
#Parameters:
#		msg,msgtype,mqname,qname,msgPriority,msgExpiry
#Return: 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub MQSend
{
	my $tempMsg 	= shift;
	my $msgType 	= shift;
	my $mname   	= shift;
	my $qname   	= shift;
	my $msgPriority = shift;
	my $msgExpiry 	= shift;

	$mname   	= $MSName 	if(!defined($mname));
	$qname   	= $MQName 	if(!defined($qname));
	$msgType   	= $DMMMT_DCMSG_TYPE 	if(!defined($msgType));
	$tempMsg  	= '<message type=00000>NULL</>'	if(!defined($tempMsg));	
	$msgPriority 	= 1 		if(!defined($msgPriority));
	$msgExpiry 	= 300 		if(!defined($msgExpiry));	

#	printf("\n===============================================\n".$tempMsg."\n===============================================\n");

	my ($msg,$rc,$cc);
	my $queue = BocoMQ->new(mname=>$mname,qname=>$qname);
	my $rt = $queue->initialize();
	if( $rt != 0)
	{
		$msg = $queue->getErrorMsg();
		$rc  = $queue->getReasonCode();
		$cc  = $queue->getCompleteCode();
		print "Err:MQ initialize error!\n";
		print "\nErrMsg=$msg\nRC=$rc CC=$cc";
		return;
	}

	$rt = $queue->sendMsg($tempMsg,$msgType,$msgPriority,$msgExpiry);
	if( $rt != 0)
	{
		
		$msg = $queue->getErrorMsg();
		$rc  = $queue->getReasonCode();
		$cc  = $queue->getCompleteCode();
		print "Err:MQ send message error!\n";
		print "\nErrMsg=$msg\nRC=$rc CC=$cc";
		return;
	}

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Function Name:	MQReceive
#Date:			2002-06-04
#Description:
#Parameters:
#		mname,qname
#Return: 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub MQReceive
{
	my $mname   	= shift;
	my $qname   	= shift;
	
	my $tempMsg;
	my $msgType;
	my $msgPriorityt;
	my $msgExpiry;

	$mname   	= $MSName 	if(!defined($mname));
	$qname   	= $MQName 	if(!defined($qname));

	my ($msg,$rc,$cc);
	my $queue = BocoMQ->new(mname=>$mname,qname=>$qname);
	my $rt = $queue->initialize();
	if( $rt != 0)
	{
		$msg = $queue->getErrorMsg();
		$rc  = $queue->getReasonCode();
		$cc  = $queue->getCompleteCode();
		print "Err:MQ initialize error!\n";
		print "\nErrMsg=$msg\nRC=$rc CC=$cc";
		return;
	}

	my $rt = 0;
	my ($msg,$rc,$cc);
		
	while($rt == 0)
	{
		$rt = $queue->receiveMsg(\$tempMsg,1);
		if( $rt == 0)
		{
			$msgType	=$queue->getMsgType();
			$msgPriorityt	=$queue->getMsgPriority();
			print "\nreceiveMsg Successfully!\n$tempMsg\n";
			print "type=$msgType,priority=$msgPriorityt\n";
		}
	}
	if( $rt != 0)
	{
		$msg = $queue->getErrorMsg();
		$rc  = $queue->getReasonCode();
		$cc  = $queue->getCompleteCode();
		print "Err:MQReceive message error!\n";
		print "\nErrMsg=$msg\nRC=$rc CC=$cc";
		return -1;		
	}
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Function Name:	FmtMsg
#Date:			2002-06-04
#Description:
#Parameters:
#Return: 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#//*************************************************//
#// DMManager - Assembler
#//*************************************************//
#// DC的消息,DMManager <- Assembler
##define NM_DMMMT_DCMSG          _T("DC的消息")
##define DMMMT_DCMSG             1201
#/* XML Body
#<?xml version = "1.0" encoding = "GB2312"?>
#<xml>
#   <message type = '1280'>
#        <sub_msgtype>1</sub_msgtype> // 消息子类型，见下
#        <task_id>57021</task_id>
#	 <task_name>test task</task_name>  
#        <instance_id>1001</instance_id>
#	 <cmd>test.pl -l -d cookdb</cmd>
#        <timestamp>2002-04-18 15:48:38</timestamp> 
#        <description>Huawei cm collection programme</description> 
#    </message>
#</xml>
#*/
#// DMMMT_DCMSG sub_msgtype
#define DMMMT_DCMSG_ST_INSSTART 1 // Instance start
#define DMMMT_DCMSG_ST_INSSTOP  2 // Instance stoped
#define DMMMT_DCMSG_ST_INSERROR 3 // running error
#define DMMMT_DCMSG_ST_INSINFO  4 // running information
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub FmtMsg
{
	my $dcmsg		= shift;
	my $task_id 	 	= shift;
	my $instance_id 	= shift;


	$DMMMT_DCMSG   		= $dcmsg 	if(defined($dcmsg));
	$DMMMT_DCMSG_TASK_ID   	= $task_id 	if(defined($task_id));
	$DMMMT_DCMSG_INSTANCE_ID= $instance_id 	if(defined($instance_id));
	$DMMMT_DCMSG_TASK_ID	= $$;
	
	$DMMMT_DCMSG_TIMESTAMP   = CFtime("YYYY-MM-DD hh:mm:ss");
	
	if ($DMMMT_DCMSG =~ /Execute\s*Time:/igm)
	{
		$DMMMT_DCMSG_ST = $DMMMT_DCMSG_ST_INSSTART;
	}
	elsif ($DMMMT_DCMSG =~ /Execute\s*End\s*Time/igm)
	{
		$DMMMT_DCMSG_ST = $DMMMT_DCMSG_ST_INSSTOP;
	}	
	elsif ($DMMMT_DCMSG =~ /Err:/igm)
	{
		$DMMMT_DCMSG_ST = $DMMMT_DCMSG_ST_INSERROR;
	}
	else
	{
		$DMMMT_DCMSG_ST = $DMMMT_DCMSG_ST_INSINFO;		
	}
#<?xml version = "1.0" encoding = "GB2312"?>	
	my $MQMsg =<<EOF;
<xml>
    <message type = '$DMMMT_DCMSG_TYPE'>
        <sub_msgtype>$DMMMT_DCMSG_ST</sub_msgtype>
        <task_id>$DMMMT_DCMSG_TASK_ID</task_id>
        <task_name>$PM_DCHK_PNAME</task_name>
        <instance_id>$DMMMT_DCMSG_INSTANCE_ID</instance_id>
        <cmd>$PROG_NAME</cmd>
        <timestamp>$DMMMT_DCMSG_TIMESTAMP</timestamp> 
        <description>
        <![CDATA[
$DMMMT_DCMSG
	]]>
	</description> 
    </message>
</xml>
EOF
return $MQMsg;

}
###########################################################################
# Added for GP-NPM_adaptor
###########################################################################
# Function:
# Description: NPM_Set_LDAP_Flag
# Input:  
#	1.LDAP_FLAG
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_LDAP_Flag
{
	$CONFIG_IN_LDAP = shift;
}
###########################################################################
# Function: Set_MSGQueue_ID
# Description: Set_MSGQueue_ID
# Input:  
#	1.Id of message queue
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_MSGQueue_ID
{
	$MESSAGE_QUEUE_ID = shift;
}
###########################################################################
# Function: Set_TPMTable_Name
# Description: Set_TPMTable_Name
# Input:  
#	1.Name of PM target table
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_TPMTable_Name
{
	$TPM_TABLE_NAME = shift;
}

###########################################################################
# Function: Set_TPMTable_Name
# Description: Set_TPMTable_Name
# Input:  
#	1.Name of PM target table
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_Message_Text
{
	$Message_Text = shift;
}

###########################################################################
# Function: Set_TPMTable_Name
# Description: Set_TPMTable_Name
# Input:  
#	1.Name of PM target table
# Output: Null
# Return: null
###########################################################################
sub NPM_Send_Message
{
	my $msg_type = shift;
	my $msg_text = shift;
	$Message_Text = $msg_text if($msg_text);
	msgsnd($MESSAGE_QUEUE_ID,pack('l a*',$msg_type,"(PID:$$)$Message_Text"),0);
}
###########################################################################
# Function: NPM_TraceMsgRecvd
# Description: NPM_TraceMsgRecvd
# Input:  
#	1. msg type
#	2. msg info
# Output: detail info
# Return: null
###########################################################################
sub NPM_TraceMsgRecvd
{
	my $msg_type	= shift;
	my $msg_text	= shift;
	
	DBIs::Trace("$msg_text : $NPM_MESSAGE->{$msg_type}\n");
}

###########################################################################
# Function: Set_TPMTable_Name
# Description: Set_TPMTable_Name
# Input:  
#	1.Name of PM target table
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_MDDB_DSN
{
	$MDDB_DSN = shift;
}

###########################################################################
# Function: Set_TPMTable_Name
# Description: Set_TPMTable_Name
# Input:  
#	1.Name of PM target table
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_DalLog
{
	
	my %arg = @_;
	$DAL_LOG_HASH->{INSTANCE_ID} 	= $arg{INSTANCE_ID}	?$arg{INSTANCE_ID}:$DAL_LOG_HASH->{INSTANCE_ID};
	$DAL_LOG_HASH->{TASK_ID} 	= $arg{TASK_ID}		?$arg{TASK_ID}:$DAL_LOG_HASH->{TASK_ID};
	$DAL_LOG_HASH->{OMC_ID} 	= $arg{OMC_ID}		?$arg{OMC_ID}:$DAL_LOG_HASH->{OMC_ID};
	$DAL_LOG_HASH->{COL_NE} 	= $arg{COL_NE}		?$arg{COL_NE}:$DAL_LOG_HASH->{COL_NE};
	$DAL_LOG_HASH->{COL_TABLE} 	= $arg{COL_TABLE}	?$arg{COL_TABLE}:$DAL_LOG_HASH->{COL_TABLE};
	$DAL_LOG_HASH->{COL_START_TIME}	= $arg{COL_START_TIME}	?$arg{COL_START_TIME}:$DAL_LOG_HASH->{COL_START_TIME};
	$DAL_LOG_HASH->{COL_STOP_TIME} 	= $arg{COL_STOP_TIME}	?$arg{COL_STOP_TIME}:$DAL_LOG_HASH->{COL_STOP_TIME};
	$DAL_LOG_HASH->{CMD_LINE} 	= $arg{CMD_LINE}	?$arg{CMD_LINE}:$DAL_LOG_HASH->{CMD_LINE};
	$DAL_LOG_HASH->{PROGRAM_NAME} 	= $arg{PROGRAM_NAME}	?$arg{PROGRAM_NAME}:$DAL_LOG_HASH->{PROGRAM_NAME};
	$DAL_LOG_HASH->{ERROR_MESSAGE} 	= $arg{ERROR_MESSAGE}	?$arg{ERROR_MESSAGE}:$DAL_LOG_HASH->{ERROR_MESSAGE};
	$DAL_LOG_HASH->{VENDOR_DATA} 	= $arg{VENDOR_DATA}	?$arg{VENDOR_DATA}:$DAL_LOG_HASH->{VENDOR_DATA};
	$DAL_LOG_HASH->{LOCAL_DATA} 	= $arg{LOCAL_DATA}	?$arg{LOCAL_DATA}:$DAL_LOG_HASH->{LOCAL_DATA};
	$DAL_LOG_HASH->{COLLECT_TAG} 	= $arg{COLLECT_TAG}	?$arg{COLLECT_TAG}:$DAL_LOG_HASH->{COLLECT_TAG};
	$DAL_LOG_HASH->{CLEAR_TAG} 	= $arg{CLEAR_TAG}	?$arg{CLEAR_TAG}:$DAL_LOG_HASH->{CLEAR_TAG};
	$DAL_LOG_HASH->{TRACE_FILE} 	= $arg{TRACE_FILE}	?$arg{TRACE_FILE}:$DAL_LOG_HASH->{TRACE_FILE};
}
###########################################################################
# Function: NPM_Write_DalLog
# Description: NPM_Write_DalLog
# Input:  
#
# Output: Null
# Return: null
###########################################################################
sub NPM_Write_DalLog
{
	my %arg = @_;
	$DAL_LOG_HASH->{INSTANCE_ID} 	= $arg{INSTANCE_ID}	?$arg{INSTANCE_ID}:$DAL_LOG_HASH->{INSTANCE_ID};
	$DAL_LOG_HASH->{TASK_ID} 	= $arg{TASK_ID}		?$arg{TASK_ID}:$DAL_LOG_HASH->{TASK_ID};
	$DAL_LOG_HASH->{OMC_ID} 	= $arg{OMC_ID}		?$arg{OMC_ID}:$DAL_LOG_HASH->{OMC_ID};
	$DAL_LOG_HASH->{COL_NE} 	= $arg{COL_NE}		?$arg{COL_NE}:$DAL_LOG_HASH->{COL_NE};
	$DAL_LOG_HASH->{COL_TABLE} 	= $arg{COL_TABLE}	?$arg{COL_TABLE}:$DAL_LOG_HASH->{COL_TABLE};
	$DAL_LOG_HASH->{COL_START_TIME}	= $arg{COL_START_TIME}	?$arg{COL_START_TIME}:$DAL_LOG_HASH->{COL_START_TIME};
	$DAL_LOG_HASH->{COL_STOP_TIME} 	= $arg{COL_STOP_TIME}	?$arg{COL_STOP_TIME}:$DAL_LOG_HASH->{COL_STOP_TIME};
	$DAL_LOG_HASH->{CMD_LINE} 	= $arg{CMD_LINE}	?$arg{CMD_LINE}:$DAL_LOG_HASH->{CMD_LINE};
	$DAL_LOG_HASH->{PROGRAM_NAME} 	= $arg{PROGRAM_NAME}	?$arg{PROGRAM_NAME}:$DAL_LOG_HASH->{PROGRAM_NAME};
	$DAL_LOG_HASH->{ERROR_MESSAGE} 	= $arg{ERROR_MESSAGE}	?$arg{ERROR_MESSAGE}:$DAL_LOG_HASH->{ERROR_MESSAGE};
	$DAL_LOG_HASH->{VENDOR_DATA} 	= $arg{VENDOR_DATA}	?$arg{VENDOR_DATA}:$DAL_LOG_HASH->{VENDOR_DATA};
	$DAL_LOG_HASH->{LOCAL_DATA} 	= $arg{LOCAL_DATA}	?$arg{LOCAL_DATA}:$DAL_LOG_HASH->{LOCAL_DATA};
	$DAL_LOG_HASH->{COLLECT_TAG} 	= $arg{COLLECT_TAG}	?$arg{COLLECT_TAG}:$DAL_LOG_HASH->{COLLECT_TAG};
	$DAL_LOG_HASH->{CLEAR_TAG} 	= $arg{CLEAR_TAG}	?$arg{CLEAR_TAG}:$DAL_LOG_HASH->{CLEAR_TAG};
	$DAL_LOG_HASH->{TRACE_FILE} 	= $TraceFileName;
	
	my (@column_array,@values_array,$i);
	my ($mddb_dbh,$mddb_sth);
	if (!$MDDB_DSN)
	{
		$MDDB_DSN	= "mddb";
	}
	my ($conn_dbd,$conn_dbn,$conn_uid,$conn_pwd) = NPM_Get_DBMS_From_LDAP($MDDB_DSN);
        if ($conn_dbd =~ /informix/i) 
        {
		$conn_dbd	= 'Informix';
                $conn_str 	= "dbi:$conn_dbd:$conn_dbn";
        }
        elsif ($conn_dbd =~ /oracle/i) 
        {
		$conn_dbd	= 'Oracle';
                $conn_str 	= "dbi:$conn_dbd:$conn_dbn";
        }
        $mddb_dbh = DBI->connect($conn_str,$conn_uid,$conn_pwd);
        if (!$mddb_dbh) 
        {
                Trace("Warning : Connect with mddb failed. Can NOT write info to dal_log!");
                return 0;
        }
        foreach my $key (keys %$DAL_LOG_HASH) {
                $column_array[$i] = $key;
                $values_array[$i] = $DAL_LOG_HASH->{$key};
                $i++;
        }
        my $statement = "INSERT INTO DAL_LOG\n(\n";
        for($i=0;$i<@column_array;$i++)
        {
        	if($i==@column_array-1)
        	{
        		$statement .= $column_array[$i]."\n)\nVALUES\n(\n";
        	}
        	else
        	{
        		$statement .= $column_array[$i].",\n";
        	}
        }
        for($i=0;$i<@values_array;$i++)
        {
        	if($i==@values_array-1)
        	{
        		$statement .= "\'$values_array[$i]\'\n)\n";
        	}
        	else
        	{
        		$statement .= "\'$values_array[$i]\',\n";
        	}
        }
	$mddb_sth = $mddb_dbh->prepare($statement);
        if(!$mddb_sth)
        {
        	DBIs::Trace("Err : $DBI::errstr!\nSQL : $statement\n");
        	return 0;
        }
        $rc = $mddb_sth->execute;
        if(!$rc)
        {
        	DBIs::Trace("Err : $DBI::errstr!\nSQL : $statement\n");
        	return 0;
        }
        $rc = $mddb_dbh->disconnect;
        if(!$rc)
        {
        	DBIs::Trace("Warning : Can NOT disconnect from MDDB!\n");
        	return 0;
        }
        
        DBIs::Trace("(PID:$$)$DAL_LOG_HASH->{COL_TABLE} : INSERT one record into DAL_LOG when ERROR occurs\n");
        return 1;
}
###########################################################################
# Function: NPM_Get_DBMS_From_LDAP
# Description: NPM_Get_DBMS_From_LDAP
# Input:  
#	1.DSN_NAME		: cookdb2
#	2.LDAP_NODE_CLASS	: dsn
# Output: Null
# Return: $sub_dbn,$sub_dbd,$sub_uid,$sub_pwd
###########################################################################
sub NPM_Get_DBMS_From_LDAP
{
	my $ou_name	= shift;
	my $ldap_base	= "ou=DSN,ou=ini,o=boco";
	my $ldap_filter	= "ou=".$ou_name;
	my $LDAP	= new LDAP_API();
	my $LDAP_Hash 	= $LDAP->get_attr_by_Filter($ldap_filter,$ldap_base);
	
	if(!$LDAP_Hash)
	{
		NPM_Send_Message(200);
		exit 0;
	}
	$LDAP_Hash	= $LDAP_Hash->{$ou_name};
	my $dbn_lab	= "db_name";
	my $dbd_lab	= "db_type";
	my $uid_lab	= "db_user";
	my $pwd_lab	= "db_pwd";
	return ($LDAP_Hash->{$dbd_lab},$LDAP_Hash->{$dbn_lab},$LDAP_Hash->{$uid_lab},$LDAP_Hash->{$pwd_lab});
}
###########################################################################
# Function: NPM_Set_DalLog_odbc
# Description: NPM_Set_DalLog for odbccollector
# Input:  
#	1.Name of PM target table
# Output: Null
# Return: null
###########################################################################
sub NPM_Set_DalLog_odbc
{
	
	my $arg = shift;
	$DAL_LOG_HASH->{INSTANCE_ID} 	= $$arg{INSTANCE_ID}	?$$arg{INSTANCE_ID}:$DAL_LOG_HASH->{INSTANCE_ID};
	$DAL_LOG_HASH->{TASK_ID} 	= $$arg{TASK_ID}	?$$arg{TASK_ID}:$DAL_LOG_HASH->{TASK_ID};
	$DAL_LOG_HASH->{OMC_ID} 	= $$arg{OMC_ID}		?$$arg{OMC_ID}:$DAL_LOG_HASH->{OMC_ID};
	$DAL_LOG_HASH->{COL_NE} 	= $$arg{COL_NE}		?$$arg{COL_NE}:$DAL_LOG_HASH->{COL_NE};
	$DAL_LOG_HASH->{COL_TABLE} 	= $$arg{COL_TABLE}	?$$arg{COL_TABLE}:$DAL_LOG_HASH->{COL_TABLE};
	$DAL_LOG_HASH->{COL_START_TIME}	= $$arg{COL_START_TIME}	?$$arg{COL_START_TIME}:$DAL_LOG_HASH->{COL_START_TIME};
	$DAL_LOG_HASH->{COL_STOP_TIME} 	= $$arg{COL_STOP_TIME}	?$$arg{COL_STOP_TIME}:$DAL_LOG_HASH->{COL_STOP_TIME};
	$DAL_LOG_HASH->{CMD_LINE} 	= $$arg{CMD_LINE}	?$$arg{CMD_LINE}:$DAL_LOG_HASH->{CMD_LINE};
	$DAL_LOG_HASH->{PROGRAM_NAME} 	= $$arg{PROGRAM_NAME}	?$$arg{PROGRAM_NAME}:$DAL_LOG_HASH->{PROGRAM_NAME};
	$DAL_LOG_HASH->{ERROR_MESSAGE} 	= $$arg{ERROR_MESSAGE}	?$$arg{ERROR_MESSAGE}:$DAL_LOG_HASH->{ERROR_MESSAGE};
	$DAL_LOG_HASH->{VENDOR_DATA} 	= $$arg{VENDOR_DATA}	?$$arg{VENDOR_DATA}:$DAL_LOG_HASH->{VENDOR_DATA};
	$DAL_LOG_HASH->{LOCAL_DATA} 	= $$arg{LOCAL_DATA}	?$$arg{LOCAL_DATA}:$DAL_LOG_HASH->{LOCAL_DATA};
	$DAL_LOG_HASH->{COLLECT_TAG} 	= $$arg{COLLECT_TAG}	?$$arg{COLLECT_TAG}:$DAL_LOG_HASH->{COLLECT_TAG};
	$DAL_LOG_HASH->{CLEAR_TAG} 	= $$arg{CLEAR_TAG}	?$$arg{CLEAR_TAG}:$DAL_LOG_HASH->{CLEAR_TAG};
	$DAL_LOG_HASH->{TRACE_FILE} 	= $$arg{TRACE_FILE}	?$$arg{TRACE_FILE}:$DAL_LOG_HASH->{TRACE_FILE};	
}
###########################################################################
# Function: NPM_Write_DalLog_bindmod
# Description: NPM_Write_DalLog use bindmod
# Input:  
#
# Output: Null
# Return: null
###########################################################################
sub NPM_Write_DalLog_bindmod
{
	my %arg = @_;
	$DAL_LOG_HASH->{INSTANCE_ID} 	= $arg{INSTANCE_ID}	?$arg{INSTANCE_ID}:$DAL_LOG_HASH->{INSTANCE_ID};
	$DAL_LOG_HASH->{TASK_ID} 	= $arg{TASK_ID}		?$arg{TASK_ID}:$DAL_LOG_HASH->{TASK_ID};
	$DAL_LOG_HASH->{OMC_ID} 	= $arg{OMC_ID}		?$arg{OMC_ID}:$DAL_LOG_HASH->{OMC_ID};
	$DAL_LOG_HASH->{COL_NE} 	= $arg{COL_NE}		?$arg{COL_NE}:$DAL_LOG_HASH->{COL_NE};
	$DAL_LOG_HASH->{COL_TABLE} 	= $arg{COL_TABLE}	?$arg{COL_TABLE}:$DAL_LOG_HASH->{COL_TABLE};
	$DAL_LOG_HASH->{COL_START_TIME}	= $arg{COL_START_TIME}	?$arg{COL_START_TIME}:$DAL_LOG_HASH->{COL_START_TIME};
	$DAL_LOG_HASH->{COL_STOP_TIME} 	= $arg{COL_STOP_TIME}	?$arg{COL_STOP_TIME}:$DAL_LOG_HASH->{COL_STOP_TIME};
	$DAL_LOG_HASH->{CMD_LINE} 	= $arg{CMD_LINE}	?$arg{CMD_LINE}:$DAL_LOG_HASH->{CMD_LINE};
	$DAL_LOG_HASH->{PROGRAM_NAME} 	= $arg{PROGRAM_NAME}	?$arg{PROGRAM_NAME}:$DAL_LOG_HASH->{PROGRAM_NAME};
	$DAL_LOG_HASH->{ERROR_MESSAGE} 	= $arg{ERROR_MESSAGE}	?$arg{ERROR_MESSAGE}:$DAL_LOG_HASH->{ERROR_MESSAGE};
	$DAL_LOG_HASH->{VENDOR_DATA} 	= $arg{VENDOR_DATA}	?$arg{VENDOR_DATA}:$DAL_LOG_HASH->{VENDOR_DATA};
	$DAL_LOG_HASH->{LOCAL_DATA} 	= $arg{LOCAL_DATA}	?$arg{LOCAL_DATA}:$DAL_LOG_HASH->{LOCAL_DATA};
	$DAL_LOG_HASH->{COLLECT_TAG} 	= $arg{COLLECT_TAG}	?$arg{COLLECT_TAG}:$DAL_LOG_HASH->{COLLECT_TAG};
	$DAL_LOG_HASH->{CLEAR_TAG} 	= $arg{CLEAR_TAG}	?$arg{CLEAR_TAG}:$DAL_LOG_HASH->{CLEAR_TAG};
	$DAL_LOG_HASH->{TRACE_FILE} 	= $TraceFileName;
	
	my (@column_array,@values_array,$i);
	my ($mddb_dbh,$mddb_sth);
	if (!$MDDB_DSN)
	{
		$MDDB_DSN	= "mddb";
	}
	my ($conn_dbd,$conn_dbn,$conn_uid,$conn_pwd) = NPM_Get_DBMS_From_LDAP($MDDB_DSN);
        if ($conn_dbd =~ /informix/i) 
        {
		$conn_dbd	= 'Informix';
                $conn_str 	= "dbi:$conn_dbd:$conn_dbn";
        }
        elsif ($conn_dbd =~ /oracle/i) 
        {
		$conn_dbd	= 'Oracle';
                $conn_str 	= "dbi:$conn_dbd:$conn_dbn";
        }
        $mddb_dbh = DBI->connect($conn_str,$conn_uid,$conn_pwd);
        if (!$mddb_dbh) 
        {
                Trace("Warning : Connect with mddb failed. Can NOT write info to dal_log!");
                return 0;
        }
        foreach my $key (keys %$DAL_LOG_HASH) {
                $column_array[$i] = $key;
                $values_array[$i] = $DAL_LOG_HASH->{$key};
                $i++;
        }
        my $statement = "INSERT INTO DAL_LOG\n(\n";
        for($i=0;$i<@column_array;$i++)
        {
        	if($i==@column_array-1)
        	{
        		$statement .= $column_array[$i]."\n)\nVALUES\n(\n";
        	}
        	else
        	{
        		$statement .= $column_array[$i].",\n";
        	}
        }
        if ($NPM_WriteDaLlog_mod==1)
        {
        	for($i=0;$i<@values_array;$i++)
        	{
        		if($i==@values_array-1)
        		{
        			$statement .= "?\n)\n";
        		}
        		else
        		{
        			$statement .= "?,\n";
        		}
        	}
		$mddb_sth = $mddb_dbh->prepare($statement);
		if(!mddb_sth)
		{
			DBIs::Trace("Err : $DBI::errstr!\nSQL : $statement\n");
        		return 0;
       		}
		$rc = $mddb_sth->execute(@values_array);
        	if(!$rc)
        	{
        		DBIs::Trace("Err : $DBI::errstr!\nSQL : $statement\n");
        		return 0;
        	}

	}
	else
	{
	        for($i=0;$i<@values_array;$i++)
        	{
        		if($i==@values_array-1)
        		{
        			$statement .= "\'$values_array[$i]\'\n)\n";
        		}
        		else
        		{
        			$statement .= "\'$values_array[$i]\',\n";
        		}
        	}
		$mddb_sth = $mddb_dbh->prepare($statement);
        	if(!$mddb_sth)
        	{
        		DBIs::Trace("Err : $DBI::errstr!\nSQL : $statement\n");
        		return 0;
        	}
        	$rc = $mddb_sth->execute;
        	if(!$rc)
        	{
        		DBIs::Trace("Err : $DBI::errstr!\nSQL : $statement\n");
        		return 0;
        	}
	}
        $rc = $mddb_dbh->disconnect;
        if(!$rc)
        {
        	DBIs::Trace("Warning : Can NOT disconnect from MDDB!\n");
        	return 0;
        }
        
        DBIs::Trace("(PID:$$)$DAL_LOG_HASH->{COL_TABLE} : INSERT one record into DAL_LOG when ERROR occurs\n");
        return 1;

}
###########################################################################
# Function: Set_NPM_DalLog_bindmod
# Description: Set_NPM_DalLog_bindmod
# Input:  1: default bind
# 	  0: no bind
# Output: 
# Return: null
###########################################################################
sub Set_NPM_DalLog_bindmod
{
	$NPM_WriteDaLlog_mod	=shift;
}
###########################################################################
# Function: NPM_Bak_Insert
# Description: insert all the data from tmptable to the backup table 
# Input:  1: the handle of db
# 	  2: the tmptab
#	  3: the backup table
# Return: 
###########################################################################
sub NPM_Bak_Insert
{
	my $subdbh 	= shift;
	my $temp_tab	= shift;
	my $obj_tab	= shift;
	my ($sth,$number,$col,$value,$rv);
	if(!($sth=$$subdbh->prepare("select * from $$temp_tab")))
	{
		$TraceModes = 'SRC|LOG|REP';
		Trace("Err:Bcp select sql prepare error!\n Err Info:".$DBI::errstr);
		NPM_Send_Message(210);
		print "********************\n";
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return 0;
	}
	$sth->execute();
	$number	= $sth->{NUM_OF_FIELDS};
	for (my $i=0;$i<$number;$i++)
	{
		$col	.= $sth->{NAME}->[$i].",";
	}
	chomp($col);
	chop($col);
	my ($array_ref,@ref_stash);
	while($array_ref = $sth->fetchrow_arrayref)
	{
		push(@ref_stash,$array_ref);
	}
	foreach $array_ref (@ref_stash)
	{
		$value = "";
		foreach $row_ref (@$array_ref)
			{
				$value .= "\'".$row_ref."\',";
			}
				
				chomp($value);
				chop($value);	
				$ins_sql = "insert into $$obj_tab (".$col.")values(".$value.");";
				if(!($rv  = $$subdbh->do($ins_sql)))
				{
					my $tmptracemodes = $TraceModes;
					$TraceModes = 'SRC|LOG|REP';		
					Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
					NPM_Send_Message(250);
					NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
					OnError($subdbh);
					$TraceModes = $tmptracemodes;
					return 0;
				}

	}
	$sth->finish();
	Trace("Has insert $number column to $$obj_tab\n");
	Commit_DB($subdbh);
}

sub NPM_Bak_Bcp
{
	use FileHandle;
	my($subdbh,$substh,$subcpdbh,$subcpsth,$subcptab,$sub_statement,$subflag,$rows,$sub_rc);
	my($sub_bind,$bind,@bind_paras,$bind_para,@paras,$i,$errows,$rv,$create_cond);
	my ($i,$counter,$colnum,$coltype,@cols_type,$colname,$counter_sql,$counter_num,
	    $colscale,$colprec,$tabschema,$cols,$cols_noid,$value_cols,$ins_sql,$type,
	    $serial_id,$oldbcptab);
	my (@fetchrow,$ROWS,$line);
	
	$subdbh 	= shift;
	$subcpdbh 	= shift;
	$subcptab	= shift;
	$sub_statement 	= shift;
	$create_cond	= shift;
	$bind 		= shift;
	$bind_para	= shift;

	Trace("Bcp($Bcptab_Serial) to $$subcptab SQL:\n".$sub_statement);
	Set_Isdirty_Read($subdbh,$OSSDB_TYPE);
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# count all data number
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	if(!$$ErrorDebug)	#if Error bebug then counter rows
	{
		$counter_sql = $sub_statement;
		
		if(!($substh = $$subdbh->prepare($counter_sql)))
		{
			$TraceModes = 'SRC|LOG|REP';	
			Trace("Bcp SQL Statement:\n$counter_sql\nErr Info:".$DBI::errstr);
			$TraceModes = 'SRC|LOG';
			NPM_Send_Message(210);
			NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
			OnError($subdbh);
			return -1;
		}
		$sub_rc = $substh->execute();	
		$counter_num = 0;
		while(@fetchrow = $substh->fetchrow_array)
		{
			$counter_num ++;
		}
		$substh->finish;
	}
	else
	{
		$counter_num = 'unknown';
	}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	if ($DeBug)
	{
	   	Trace("***Programming Debug!! return!!!\n");
	   	return -1;
	} 
	if(!($substh = $$subdbh->prepare($sub_statement)))
	{
		$TraceModes = 'SRC|LOG|REP';			
		Trace("Err:Sql prepare error!\nSQL Statement:$sub_statement\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(210);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}

	if ($bind == 1)
	{
		@bind_paras = $bind_para =~ /\([^\(\)]*\)/g;
		$i = 0;
		foreach $bind_para (@bind_paras)
		{
			$bind_para =~ s/\(|\)//g;
			@paras = split(",",$bind_para);
			@paras[2] = eval(@paras[2]);
			Trace("Bind Parameter:$bind_para\n\tParaNo.@paras[0] = @paras[1]");
			$i ++;
			if (@paras[0] != $i)
			{
					Trace("Err:Bind Parameter error!Parameter:@paras");
			}
			else
			{
				$sub_rc = $substh->bind_param(@paras);
				if (not $sub_rc)
				{
					$TraceModes = 'SRC|LOG|REP';	
					Trace("Err:Execute sql bind error!bind_param\(@paras\)");
					$TraceModes = 'SRC|LOG';
					NPM_Send_Message(211);
					NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
					OnError($subdbh);
					return -1;
				}
			}
			
		}
	}
	$sub_rc = $substh->execute();
	if(not $sub_rc)
	{
		$TraceModes = 'SRC|LOG|REP';	
		Trace("Err:Execute sql error!\nSQL Statement:$sub_statement\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(212);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}
	
	Trace ("\nSQL Info:\n",0);
	
	Trace ("Column Name	    TypeName            DataType   Precision  Scale\n",0);
	Trace ("===================================================================\n",0);

	
	$colnum = $substh->{NUM_OF_FIELDS};
	my ($col_infor,$spaces,$infor_tmp);
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Serial Id
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#	$colname = $$subcptab."_ID";
#	$cols = $colname.",";
#	$coltype = $SQL_TYPE_INFO->{$COOKDB_TYPE}->{4};
#	#SQL_INTEGER
#	$tabschema 	.= $colname."\t".$coltype.",\n";
#	Trace ("$colname  SQL_INTEGER         4          -          -    \n",0);
#	$serial_id = 0;
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	for($i=0;$i<$colnum;$i++)
	{
#		@typenames 	= map {scalar $dbh->type_info($_)->{TYPE_NAME} } @{ $sth->{TYPE} }
		$type		= $substh->{TYPE}->[$i];
		@cols_type[$i]	= $type;
		#$coltype 	= $$subcpdbh->type_info($type)->{TYPE_NAME};

		$coltype 	= $SQL_TYPE_INFO->{$COOKDB_TYPE}->{$type};
		$colname 	= $substh->{NAME}->[$i];
		$colscale 	= $substh->{SCALE}->[$i];
		$colprec 	= $substh->{PRECISION}->[$i];
		$infor_tmp	= $colname;
		$col_infor      = $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 20 - length($infor_tmp);
		$col_infor     .= $spaces;
		
		$infor_tmp	= $SQL_STANDARD_NUM_TYPE{$type};
		$col_infor     .= $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 20 - length($infor_tmp);
		$col_infor     .= $spaces;
		
		$infor_tmp	= $type;
		$col_infor     .= $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 11 - length($infor_tmp);
		$col_infor     .= $spaces;

		$infor_tmp	= $colprec;
		$col_infor     .= $infor_tmp;
		$spaces		= ' ';
		$spaces        x= 11 - length($infor_tmp);
		$col_infor     .= $spaces;

		$infor_tmp	= $colscale;
		$col_infor     .= $infor_tmp;

		Trace ("$col_infor",0);
		
		if ($colscale <= 0 or $colscale >= $colprec)
		{
			$colscale = 0;
		}
		if($type == 1 or $type == 12 or $type == -1)
		{
			if (($type == 12 or $type == -1) and $colprec > 255)
			{
				$colprec = 255;
			}			
			$coltype = $coltype."(".$colprec.")";
		}
		if($type == 3)
		{
			if ($colprec > 255)
			{
				$colprec = 255;
			}
			$coltype = $coltype."(".$colprec.",".$colscale.")";
		}
		if($type == 2)
		{
			if ($colscale > 0)
			{
				$coltype = $SQL_TYPE_INFO->{$COOKDB_TYPE}->{3};
				$coltype = $coltype."(".$colprec.",".$colscale.")";
			}
		}
		$tabschema 	.= $colname."\t".$coltype.",\n";
		$cols	 	.= $colname.","

	}
	chomp($tabschema);
	chop($tabschema);

#	$tabschema .= "PRIMARY KEY (".$$subcptab."_ID)";

	chomp($cols);
	chop($cols);	
	
	#$cols = $cols.$cols_noid;
	
	Trace ("===================================================================\n",0);
	$tabschema = "CREATE TABLE $$subcptab\n\(\n".$tabschema."\n\)";
	Trace("\nCREATE TABLE SQL:\n".$tabschema,0);

	if(!($subcpsth = $$subcpdbh->prepare($tabschema)))
	{
		$TraceModes = 'SRC|LOG|REP';	
		Trace("Bcp create table statement:\n$tabschema\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(210);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}
	if(!($subcpsth->execute()))
	{
		$TraceModes = 'SRC|LOG|REP';	
		Trace("Bcp create table statement:\n$tabschema\nErr Info:".$DBI::errstr);
		$TraceModes = 'SRC|LOG';
		NPM_Send_Message(212);
		NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
		OnError($subdbh);
		return -1;
	}	
	
	$$subcpdbh->commit;
	
	$TraceModes = 'SRC|LOG';
	Trace("\nBcp all of $counter_num rows to table $$subcptab!!\n",0);
	$TraceModes = "";
#----------------------------INSERT From local database--------------
# This is Not right so can not use
#--------------------------------------------------------------------
	if ($BcpMode == 3)
	{
		$ins_sql = "insert into $$subcptab (".$cols_noid.")\n$sub_statement";
		$TraceModes = 'SRC|LOG';
		Trace("\nBcp from local database(or db link mode)!!\n\n$ins_sql\n",0);
		if(!($rv  = $$subcpdbh->do($ins_sql)))
		{
			$TraceModes = 'SRC|LOG|REP';		
			Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
			$TraceModes = 'SRC|LOG';
			NPM_Send_Message(250);
			NPM_Write_DalLog_bindmod(ERROR_MESSAGE=>"$DBI::errstr");
			OnError($subdbh);
			return -1;
		}
		$TraceModes = 'SRC|LOG';
		Trace("Bcp Finished!\n",0);
		return 0;		
	}
#----------------------------INSERT WITH LOAD------------------------
# This is Not right so can not use
#--------------------------------------------------------------------
	if(($COOKDB_TYPE eq 'ORACLE') and ($BcpMode == 2))
	{
		$TraceModes = 'SRC|LOG|REP';
		Trace("Warning:Oracle database can not use bcp load at present!\n");
		$TraceModes = 'SRC|LOG';
		$BcpMode = 0;
	}
	if ($BcpMode == 2)
	{

		if (!(-e "$INFORMIXDIR/bin/dbload"))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Warning:$INFORMIXDIR/bin/dbload not exist,can not use bcp load at present!\n");
			$TraceModes = 'SRC|LOG';
			$BcpMode = 0;
		}		
	}
	if ($BcpMode == 2)
	{
		if(!$Data_Load_TmpDir)
		{
			$Data_Load_TmpDir = "$DAL_HOME/tmp/dbload";
		}
		my $dbloaddatfile 	= "$Data_Load_TmpDir/$$subcptab.unl";
		my $dbloadcmdfile 	= "$Data_Load_TmpDir/$$subcptab.cmd";
		my $dbloadlogdfile 	= "$Data_Load_TmpDir/$$subcptab.log";
		my $dbloadsql		= "$Data_Load_TmpDir/$$subcptab.sql";
		my $dbloadcmd 		= "$INFORMIXDIR/bin/dbload -d $Wnms_Database -c $dbloadcmdfile -l $dbloadlogdfile";

#----------------------------------------------------------------------------		
#dbload [-d dbname] [-c cfilname] [-l logfile] [-e errnum] [-n nnum]
#        [-i inum] [-s] [-p] [-r | -k] [-X]
#
#        -d      database name
#        -c      command file name
#        -l      bad row(s) log file
#        -e      bad row(s) # before abort
#        -s      syntax error check only
#        -n      # of row(s) before commit
#        -p      prompt to commit or not on abort
#        -i      # or row(s) to ignore before starting
#        -r      loading without locking table
#        -X      recognize HEX escapes in character fields
#        -k      loading with exclusive lock on table(s)
#----------------------------------------------------------------------------
		
		if (!(-e "$Data_Load_TmpDir") or !(-d "$Data_Load_TmpDir"))
		{
			&Touch_Dir("$Data_Load_TmpDir");
		}
		
		if(!(open(CMDFILE,">".$dbloadcmdfile)))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Create dbload cmd file $dbloadcmdfile error!\n");
			$TraceModes = 'SRC|LOG';
			OnError($subcpdbh);
			return -1;			
		}
		
		print CMDFILE "FILE $Data_Load_TmpDir/$$subcptab.unl DELIMITER \'|\' ".($colnum+1).";\n";
		print CMDFILE "INSERT INTO $$subcptab;";	
		close(CMDFILE);

		$TraceModes = 'SRC|LOG';
		Trace("\nBcp with Load to File $dbloaddatfile!!Waiting...\n",0);
		$TraceModes = "";
		my $dfile = new FileHandle(">$dbloaddatfile");
		if(!defined $dfile)
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Open data file $dbloaddatfile error!\n");
			$TraceModes = 'SRC|LOG';
			OnError($subcpdbh);
			return -1;			
		}

		$serial_id = 0;
		my $file_buf;
		while(@fetchrow = $substh->fetchrow_array)
		{
			$line = "";
			$serial_id ++;
			#$line = $serial_id.'|';
			for($i=0;$i<@fetchrow;$i++)
			{
				@fetchrow[$i] = Trim(@fetchrow[$i]);
				if ($substh->{TYPE}->[$i] == 11)
				{
					if (@fetchrow[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
					{
						@fetchrow[$i] = $1;
					}
				}
				$line .= @fetchrow[$i]."|";
				
			}
			chop($line);
			$file_buf .= $line."\n";
			$rows ++;
			if (($rows % 1000) == 0)
			{
				print $dfile $file_buf;
				undef $file_buf;
				printf ("\n\t%7d of $counter_num rows have finished!",$rows);
				
			}
		}
		print $dfile $file_buf;
		undef $file_buf;
		close($dfile);
		
		$TraceModes = 'SRC|LOG';
		Trace("\nBcp with Load To Table $$subcptab!!Waiting...\n\n",0);
		
		if(!(open(CMDSQL,">".$dbloadsql)))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Create dbload cmd file $dbloadcmdfile error!\n");
			$TraceModes = 'SRC|LOG';
			OnError($subcpdbh);
			return -1;			
		}
		print CMDSQL "Load from /opt/informix/odbccol/$$subcptab.unl delimiter \'|\' insert into $$subcptab";
		my $ftp = new Net::FTP("10.0.5.9",Timeout=>30,Debug=>1) || die "Can't connect: $@\n";
   		$ftp->login("informix","informix") || die "Couldn't authenticate, even with explicit username and password.\n";
   		$ftp->put($dbloaddatfile,"/opt/informix/odbccol/$$subcptab.unl");
   		$ftp->put($dbloadsql,"/opt/informix/$$subcptab.sql");
   		$ftp->quit;
   		my $net = new Net::Telnet (Timeout => 120,Prompt => '/[\$%#>]\s*$/');
		$net->open("10.0.5.9");
		$net->login("informix","informix");
		$net->cmd("dbaccess mddb $$subcptab.sql");
		$net->close;
		
		system($dbloadcmd);
		if($Del_Bcpfile)
		{
			unlink($dbloaddatfile);
			unlink($dbloadcmdfile);
			unlink($dbloadlogdfile);
		}
		Trace("Bcp Finished!\n",0);
		return 0;
	}
#----------------------------INSERT NOT BIND------------------------
  
	if ($BcpMode == 0)
	{
		if ($BcpBuffer)
		{
			$TraceModes = 'SRC|LOG';
			Trace("\nBcp not Bind to Buffer!!Waiting...\n",0);
			$TraceModes = "";
			my (@fetchrow,$ary_ref,$rows,$row_ref);
			while(@fetchrow = $substh->fetchrow_array)
			{
				push(@$ary_ref,[@fetchrow]);
				$rows ++;
				if (($rows % 5000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$rows);
				}
			}
			$counter_num = $counte;
			$TraceModes = 'SRC|LOG';	
			Trace("\nBcp not Bind to Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";
			$serial_id = 0;
			foreach $row_ref (@$ary_ref)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++;
				#$value_cols = "\'".$serial_id."\',";
#-------------optimize not use Time (2002-01-01 00:00:00.000=>2002-01-01 00:00:00)------------
				for($i=0;$i<@$row_ref;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@$row_ref[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@$row_ref[$i] = $1;
						}
					}
					$value_cols .= "\'".@$row_ref[$i]."\',";
					
				}
				chomp($value_cols);
				chop($value_cols);
#---------------------------------------------------------------------------------------------
#				$value_cols = join("\',\'",@$row_ref);
#				$value_cols = "\'".$value_cols."\'";
#---------------------------------------------------------------------------------------------				
				$ins_sql = "insert into $$subcptab (".$cols.")values(".$value_cols.");";
#				&Exec_Sql($subcpdbh,\$subcpsth,$ins_sql);
#--------------------------------optimize not use Exec_Sql--------------------------------
				if(!($rv  = $$subcpdbh->do($ins_sql)))
				{
					$TraceModes = 'SRC|LOG|REP';		
					Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
					$TraceModes = 'SRC|LOG';
#					OnError($subdbh);
				}
#--------------------------------------------------------------------------------				
				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
				}
			}
			$counter_num = $counter;
			undef($ary_ref);
			$TraceModes = 'SRC|LOG';
		
			Trace("\nBcp Finished! $counter rows!\n",0);
			$substh->finish;			
		}
		else
		{
			$TraceModes = 'SRC|LOG';			
			Trace("\nBcp not Bind To Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";
			my @fetchrow;
			$serial_id = 0;
			while(@fetchrow = $substh->fetchrow_array)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++;
				#$value_cols = "\'".$serial_id."\',";
#-------------optimize not use Time (2002-01-01 00:00:00.000=>2002-01-01 00:00:00)------------
				for($i=0;$i<@fetchrow;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@fetchrow[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@fetchrow[$i] = $1;
						}
					}
					$value_cols .= "\'".@fetchrow[$i]."\',";
					
				}
				chomp($value_cols);
				chop($value_cols);
#---------------------------------------------------------------------------------------------
#				$value_cols = join("\',\'",@fetchrow);
#				$value_cols = "\'".$value_cols."\'";
#---------------------------------------------------------------------------------------------
				$ins_sql = "insert into $$subcptab (".$cols.")values(".$value_cols.");";
#--------------------------------optimize not use Exec_Sql--------------------------------
#				&Exec_Sql($subcpdbh,\$subcpsth,$ins_sql);
#---------------------------------------------------------------------------------------------
				if(!($rv  = $$subcpdbh->do($ins_sql)))
				{
					$TraceModes = 'SRC|LOG|REP';		
					Trace("Err:Bcp to insert data error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
#					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
				}
#--------------------------------------------------------------------------------				

				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
				}
			}
			$TraceModes = 'SRC|LOG';
		
			Trace("Bcp Finished! $counter rows!\n",0);
			$substh->finish;
		}
		Commit_DB($subcpdbh);
		return $counter;
	}
#----------------------------INSERT WITH BIND------------------------
	if ($BcpMode == 1)
	{
		#$value_cols = "?";
		for($i=0;$i<$colnum;$i++)
		{
			if ($value_cols)
			{
				$value_cols .= ',?';
			}
			else
			{
				$value_cols = '?';
			}
		}
		$ins_sql = "insert into $$subcptab (".$cols.")values(".$value_cols.");";
		if(!($subcpsth = $$subcpdbh->prepare($ins_sql)))
		{
			$TraceModes = 'SRC|LOG|REP';
			Trace("Err:Bcp insert bind sql prepare error!\nSQL Statement:$ins_sql\nErr Info:".$DBI::errstr);
			NPM_Send_Message(210);
			NPM_Write_DalLog(ERROR_MESSAGE=>"$DBI::errstr");
			OnError($subcpdbh);
			return -1;
		}
		if ($BcpBuffer)
		{
			$TraceModes = 'SRC|LOG';
			Trace("\nBcp with Bind to Buffer!!Waiting...\n",0);
			$TraceModes = "";
			my (@fetchrow,$ary_ref,$rows,$row_ref);
			while(@fetchrow = $substh->fetchrow_array)
			{
				push(@$ary_ref,[@fetchrow]);
				$rows ++;
				if (($rows % 5000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$rows);
				}
			}
			$counter_num = $counte;
			$TraceModes = 'SRC|LOG';			
			Trace("\nBcp with Bind To Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";
			$serial_id = 0;
			foreach $row_ref (@$ary_ref)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++;
				for($i=0;$i<@$row_ref;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@$row_ref[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@$row_ref[$i] = $1;
						}
					}
				}
				#unshift(@$row_ref,$serial_id);
				if(!($subcpsth -> execute(@$row_ref)))
				{
					$TraceModes = 'SRC|LOG|REP';
					$errows = join(",",@$row_ref);
					Trace("Err:Bcp insert date error!\nInsert values:$errows\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
#					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
				}
			
				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
				}
			}
			undef($ary_ref);		
			$TraceModes = 'SRC|LOG';
		
			Trace("Bcp Finished! $counter rows!\n",0);
			$substh->finish;		
		}
		else
		{
			
	
			$TraceModes = 'SRC|LOG';			
			Trace("\nBcp with Bind To Table $$subcptab!!Waiting...\n\n",0);
			$TraceModes = "";	
			my @fetchrow ;	
			$serial_id = 0;
			while(@fetchrow = $substh->fetchrow_array)
			{
				$value_cols = "";
				$counter ++;
				$serial_id ++ ;
				for($i=0;$i<@fetchrow;$i++)
				{
					if ($substh->{TYPE}->[$i] == 11)
					{
						if (@fetchrow[$i] =~ /^\s*(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}).*$/)
						{
							@fetchrow[$i] = $1;
						}
					}
				}
				#unshift(@fetchrow,$serial_id);
				if(!($subcpsth -> execute(@fetchrow)))
				{
					$TraceModes = 'SRC|LOG|REP';
					$errows = join(",",@fetchrow);
					Trace("Err:Bcp insert date error!\nInsert values:$errows\nErr Info:".$DBI::errstr);
					Trace("\nIgnore...\n",0);
#					OnError($subdbh);
					$TraceModes = 'SRC|LOG';
				}
			
				if (($counter % 1000) == 0)
				{
					printf ("\n\t%7d of $counter_num rows have finished!",$counter);
#--------------------------------------------------------------------------------
					if ($COOKDB_TYPE eq 'ORACLE')
					{
						Commit_DB($subcpdbh);
					}
#--------------------------------------------------------------------------------
	
				}
			}
			$TraceModes =  "SRC|LOG";
		
			Trace("Bcp Finished! $counter rows!\n",0);
			$substh->finish;
		}
		Commit_DB($subcpdbh);
		return $counter;
	}
}

###########################################################################
# Function: OnError
# Description: On Error statement 
# Input:  
#	1.dbh pointer
# Output: Null
# Return: Null
###########################################################################
sub OnError()
{
	my $subdbh = shift;

	if ($DeBug)
	{
		Trace("Call OnError!\n");
	   	Trace("***Programming Debug!! return!!!\n");
	   	return 0;
	} 
	
        if($ErrorDebug)
        {
                Debug($subdbh);
        }
	if($ErrorRollBack)
	{
		Rollback_DB($subdbh);
	}
	if($ErrorCommit)
	{
		Commit_DB($subdbh);
	}
	if($subdbh)
	{
		Disonnect_DB($subdbh);
	}
	# added by zhangjj, when error occurs, copy .log file to .err file for easy recognition
	my $Error_Log_Dir 	= "$DAL_HOME/trace/ERROR_LOG";
	# judge whether $Error_Log_Dir exists, if not, create it
	if (!-e $Error_Log_Dir)
	{
	    unless (mkdir($Error_Log_Dir,0755))
	    {
    		TRACE("Err: Create trace directory --$Error_Log_Dir failed because of $^E\n");
    		exit 0;
	    }
	}

	`cp $TraceFileName $TraceFileName.error`;	# added by zjj on 2002/10/14
	`mv $TraceFileName.error $Error_Log_Dir`;	# added by zjj on 2002/10/14

	if($ErrorExit)
	{
		if ($WriteOlog)
		{
			Write_OlogDB(2);
		}
		Trace("OnError and Exit!\n");
		exit 0;
	}
}

return 1;
