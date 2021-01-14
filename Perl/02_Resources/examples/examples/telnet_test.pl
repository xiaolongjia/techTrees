#!/usr/bin/perl

use Net::Telnet;
use Net::FTP;
use Data::Dumper;

$telnet_hdl=new Net::Telnet (Timeout => 1800, Prompt => '/[\$%#>:]\s*$/');
$telnet_hdl->open(Host=>"133.197.19.2",Timeout=>"60");
$telnet_hdl->login("wangguan","wangguan");
my $cmd ="grep \'2003-07-08 23:00\' /spool/bss/obsynt/cc2_1_114/20030708/*";
print "$cmd\n";
my @cmd = $telnet_hdl->cmd($cmd);
print "88888888888888\n".$cmd[0]."\n888888888888\n";
print Dumper(\@cmd);
$telnet_hdl->print($cmd);
my ($result_msg,$match)=$telnet_hdl->waitfor(Match=>"/\$/",Timeout=>"120");
print "$result_msg\n$match\n";
$telnet_hdl->close();
