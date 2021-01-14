#!/usr/bin/env perl

use Net::Telnet;
use Net::FTP;
use Data::Dumper;

$telnet_hdl=new Net::Telnet (Timeout => 1800, Prompt => '/[\$%#>:]\s*$/');
$telnet_hdl->open(Host=>"10.161.9.137",Timeout=>"60");
$telnet_hdl->login("datacap","datacap");
$telnet_hdl->cmd("cd /tmp/");
print "cd /tmp/\n";
$telnet_hdl->cmd("tar cvf 1.tar ./*sh");
print "tar cvf 1.tar ./*sh \n";
$telnet_hdl->cmd("compress 1.tar");
print "compress 1.tar \n";
$telnet_hdl->close();

# Ftp 

my $ftp=Net::FTP->new("10.161.9.137", Debug => 0,Timeout=>$timeout);
$ftp->login("datacap","datacap");
$ftp->binary();
print "get /tmp/1.tar.Z \n";
$ftp->get("/tmp/1.tar.Z","/tmp/2.tar.Z");
$ftp->quit;
