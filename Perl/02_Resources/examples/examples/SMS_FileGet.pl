
#################################################################################
#  @(#) Perl Module: SMS_FileGet.pl
#
#  Author(s): Tim.JIA
#
#  Creation Date: 2005-11-24
#
#  Last update Date: 2005-11-24
#
#  Description:
#
################################################################################

use strict;

use Env qw(DPIPE_HOME DPIPE_TMP);

use lib "$DPIPE_HOME/lib","$DPIPE_HOME/bin";

use Getopt::Long;
use Data::Dumper;
use Date::Format;
use File::Copy;
use File::Path;
use FileHandle;

use Net::FTP;

use BOCO_Trace;
use BOCO_ParseDate;

#---------------------------------------
# check trace dir
#---------------------------------------
my $trace_dir	= $DPIPE_HOME."/log/";
if (!check_dir($trace_dir)) {
	if (!mk_dir($trace_dir)) {
		print "Failed to create trace directory: $trace_dir !! \n";
		exit;
	}
}

my $data_dir = $DPIPE_TMP."/SMS_BOCO_DATA/";
if (!check_dir($data_dir)) {
	if (!mk_dir($data_dir)) {
		print "Failed to create data directory: $data_dir !! \n";
		exit;
	}
}

my $dest_txt_dir = $DPIPE_HOME."/data/ImportData/SMS_BOCO_DATA/";
if (!check_dir($dest_txt_dir)) {
	if (!mk_dir($dest_txt_dir)) {
		print "Failed to create data directory: $dest_txt_dir !! \n";
		exit;
	}
}

#---------------------------------------------------------------
# Init trace file (it include : huawei_sms_error.log and huawei_sms_detail.log)
#---------------------------------------------------------------
my $trace_file  = $trace_dir."Boco_sms_detail.log";
my $errlog_file = $trace_dir."Boco_sms_error.log";
Init_Trace($trace_file,$errlog_file);

#---------------------------------------------------------------
# Check ini file (BOCO_SMS_FileGet_Config.ini)
# if it doesn't exist, then rename BOCO_SMS_FileGet_Config.ini.bak 
# to BOCO_SMS_FileGet_Config.ini
#---------------------------------------------------------------
if (!check_file("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini")) {
	Write_Trace("Config file: $DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini not exists or read !",2);
	if (check_file("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini.bak")) {
		copy("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini.bak","$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini") or Write_Trace("Can't cp BOCO_SMS_FileGet_Config.ini.bak to BOCO_SMS_FileGet_Config.ini",2);
		if (!check_file("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini")) {
			Write_Trace("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini can not be recovered!",2);
			exit;
		}
		else {
			Write_Trace("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini be recovered by BOCO_SMS_FileGet_Config.ini.bak");
		}
	}
	else {
		Write_Trace("$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini.bak not exists,Can't recover ini file!",2);
		exit;
	}
}

#------------------------------------------------
# read ini file and get the server information
#------------------------------------------------
my ($server_hash,$server_id);
my $line=0;
open(SMSREAD,"$DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini") or die "Can't open file: $DPIPE_HOME/bin/BOCO_SMS_FileGet_Config.ini";
while(<SMSREAD>) {
	my $data = $_;
	chomp($data);
	$line++;
	if ($data =~ /\[\s*SERVER ID=(\w+)\]/i) {
		$server_id = $1;
	}
	elsif ($data =~ /(.+)=(.+)/ and $data !~ /\[.*SERVER ID.*\]/i) {
		$server_hash->{$server_id}{$1} = $2;
	}
}
Write_Trace("Get server information Successfully!");

#---------------------------------------------------------------
# Get Parameters from cmd line
#---------------------------------------------------------------
my $crr_year = time2str("%Y",parsedate("today"));
my ($start_time,$end_time);
GetOptions("s=s" => \$start_time, "e=s" => \$end_time);
if (!$start_time or !$end_time) {
	$end_time = time2str("%Y-%m-%d %H:00:00",parsedate("today"));
	$start_time = time2str("%Y-%m-%d %H:00:00",(parsedate($end_time)-3600));
}
Write_Trace("Start time: $start_time");
Write_Trace("End   time: $end_time");

my $timer = time_split($start_time,$end_time,24*3600);

#--------------------------------------
# Collect datafile from each server
#--------------------------------------
my @csv_file;
foreach $server_id (sort{$a<=>$b} keys %$server_hash) {
	my $crr_server = $server_hash->{$server_id};
	my $ip = $crr_server->{'IP'};
	my $user = $crr_server->{'USER'};
	my $passwd = $crr_server->{'PASSWORD'};
	my $dir = $crr_server->{'BASE_DIRECTORY'};
	my $network = $crr_server->{'NETWORK'};
	my $server_name = $crr_server->{'SERVER_NAME'};
	if ($dir !~ /\/$/) { $dir .= "/";}
	
	#--------------------------
	# Get file list
	#--------------------------
	my (@r_file_list,@d_file_list);
	for(@$timer) {
		my $crr_time = $_;
		$crr_time =~ /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):\d+/;
		my $year = $1;
		my $month = $2;
		my $day = $3;
		my $hour = $4;
		my $min = $5;
		my $file = $crr_server->{'FILE_NAME'};
		$file =~ s/\[yyyy\]/$year/;
		$file =~ s/\[MM\]/$month/;
		$file =~ s/\[dd\]/$day/;
		$file =~ s/\[HH\]/$hour/;
		$file =~ s/\[mm\]/$min/;
		$file = $dir.$file;
		push @r_file_list,$file;
		$file =~ /.*\/(.*)/;
		push @d_file_list,$data_dir.$$."_"."$year$month$day$hour${min}-BOCO-${server_name}-BOCO-$1";
	}
	Write_Trace("File: @r_file_list");
	print Dumper(\@r_file_list);
	print Dumper(\@d_file_list);
	
	#-------------------------------
	# Make a Ftp connect to server
	#-------------------------------
	Write_Trace("Connect to server $server_id , IP: $ip");
	my $ftp = Net::FTP->new("$ip", Debug => 0,Timeout=>120);
	if(!($ftp->login("$user","$passwd"))){
		my $err_msg="ftp $ip failed: user=$user,password=$passwd !";
		Write_Trace($err_msg,2);
	}
	else {
		Write_Trace("Connect Successfully");
		$ftp->binary();
		for(my $i=0;$i<@r_file_list;$i++) {
			my $remote_file = $r_file_list[$i];
			my $dest_file = $d_file_list[$i];
			my $getfile=$ftp->get($remote_file ,$dest_file);
			if($getfile ne $dest_file) {
				Write_Trace("get $remote_file fail!",2);
			}
			else {
				push @csv_file,$dest_file;
				Write_Trace("get $remote_file successfully!");
			}
		}
		Write_Trace("FTP Connection closed .");
		$ftp->close();
	}
}

#-------------------------------------
# Prepare Datafiles
#-------------------------------------
my $dest_txt_file = $dest_txt_dir."BOCO_SMS_".$$.".txt";
if (!open(DESTWRITE,">>$dest_txt_file")) {
	Write_Trace("Can not Create file: $dest_txt_file",2);
	exit;
}
Write_Trace("Write dest txt file for Import data");
Write_Trace("TXT File: $dest_txt_file");

for(@csv_file) {
	my $csv_filename = $_;
	$csv_filename =~ /.*\/.*\d+-BOCO-(.*)-BOCO-.*csv/;
	my $ne_name = $1;

	#-------------------------------------------------
	# if the last data is recorded in a file, we get it as the STD data.
	# if not, we open a file for record the STD data.
	#-------------------------------------------------
	my $std_line;
	my $time_recordfile = "$DPIPE_HOME/bin/${ne_name}_timerecord.ini";
	if (!check_file("$DPIPE_HOME/bin/${ne_name}_timerecord.ini")) {
		Write_Trace("NE Config file: $DPIPE_HOME/bin/${ne_name}_timerecord.ini not exists!",2);
		open(TIMEWRITE,">$time_recordfile");
	}
	else {
		open(TIMEREAD,$time_recordfile);
		while(<TIMEREAD>) {
			$std_line = $_;
			chomp($std_line);
		}
		close(TIMEREAD);
		open(TIMEWRITE,">$time_recordfile");
	}
	
	Write_Trace("Prepare  file: $csv_filename Starting...");
	Write_Trace("INIT STD data:\n\t$std_line\n");
	
	if (!open(DESTREAD,$csv_filename)) {
		Write_Trace("Can't open file: $csv_filename");
		next;
	}
	while(<DESTREAD>) {
		my $data = $_;
		chomp($data);
		my $time;
		if ($data =~ /^(\d{2})(\d{2})(\d{2})(\d{2}),/) {
			$time = $crr_year."-$1-$2 $3:$4:00";
			$data =~ s/^\d{8}/$time/;
		}
		if ( (parsedate($time) >= parsedate($start_time)) and (parsedate($time) < parsedate($end_time))) {
			if ($std_line) {
				my @std = split/,/,$std_line;
				my @data = split/,/,$data;
				if ( parsedate($time) == (parsedate($std[0])+300)) {
					my $new_data = $data[0].",";
					for (my $i=1;$i<@data;$i++) {
						my $delta = $data[$i]-$std[$i];
						if ($delta >=0) {
							$new_data .= $delta.",";
						}
						else {
							$new_data .= "0,";
						}
					}
					chop($new_data);
					print DESTWRITE $ne_name,",",$new_data,"\n";
					$std_line = $data;
				}
				else {
					$std_line = $data;
					my @data = split/,/,$data;
					my $length = @data -1;
					my $new_data;
					for (my $i=0;$i<=$length;$i++) {
						if ($i == 0) {
							$new_data = $data[0].",";
						}
						else {
							$new_data .= "0,";
						}
					}
					chop($new_data);
					print DESTWRITE $ne_name,",",$new_data,"\n";
				}
			}
			else {
				$std_line = $data;
				my @data = split/,/,$data;
				my $length = @data -1;
				my $new_data;
				for (my $i=0;$i<=$length;$i++) {
					if ($i == 0) {
						$new_data = $data[0].",";
					}
					else {
						$new_data .= "0,";
					}
				}
				chop($new_data);
				print DESTWRITE $ne_name,",",$new_data,"\n";
			}
		}
		else {
			$std_line = $data;
		}
	}
	print TIMEWRITE $std_line,"\n";
	close(TIMEWRITE);
	close(DESTREAD);
	Write_Trace("Prepare End.");
	unlink($csv_filename);
}

Write_Trace("Delete csv file Successed.");
Close_Trace();
close(DESTWRITE);

#--------------
#	End
#--------------

sub check_dir {	
	my $dir = shift;
	if( ! -d $dir || ! -w $dir || ! -r $dir || ! -x $dir ) {
		return 0;
	}
	else {
		return 1;
	}
}

sub mk_dir {
	my $dir = shift;

	if (!-e $dir) {
		unless (mkpath($dir)) {
			return 0;
		}
	}
	return 1;
}

sub check_file {
	my $file = shift;
	if( ! -e $file || ! -r $file ) {
        	return 0;
	}
	return 1;
}

sub time_split {
	my $start_time = shift;
	my $end_time = shift;
	my $distance = shift;
	my @time;
	my $max_number = (parsedate($end_time)-parsedate($start_time))/$distance;
	for (my $i=0;$i<$max_number;$i++) {
		push @time,time2str("%Y-%m-%d %T",(parsedate($start_time)+$i*$distance));
	}
	return (\@time);
}

sub mv_file {
	my $file = shift;
	my $dest_file = shift;
	rename($file , $dest_file);
}

