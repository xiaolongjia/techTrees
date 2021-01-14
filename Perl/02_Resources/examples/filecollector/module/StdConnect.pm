package StdConnect;

###############################################################################
#
#  @(#) Perl Module: StdConnect
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JiaXiaoLong
#
#  Creation Date:2002-12-20
#
#  Description: this module handles all kinds of connecting method.
#
#
###############################################################################

use Net::Telnet();
use Data::Dumper;
use Exporter;
use XML::Simple;
use DBIs;

@ISA=('Exporter');
@EXPORT=qw(connect_telnet connect_sie8_socket);

local $err_msg;

$r_handle_telnet_error=sub {
	$err_msg=shift;
	print "It is in handle_telnet_error now. \n";
	return 1;
};

$r_handle_socket_error=sub {
	$err_msg=shift;
	print "It is in handle_socket_error now. \n";
	return 1;
};

$r_handle_loginNE_error=sub{
	$err_msg=shift;
	print "It is in handle_loginNE_error now. \n";
	return $err_msg;
};

##############################################################
#
#  Function:connect_telnet
#
#  Input:ref of a hash which contains the information for creating 
#	 a handle of telnet.This hash has following structure:
#	{
#		'Nename'=>host_name or host IP address,
#		'Username'=>user_name,
#		'Password'=>password,
#		'timer'=>time_out
#	}
#
#  Output:
#
#  Return value:(1, telnet success,$telnet_hdl) success,
#		(-1,$err_msg) bad name or passwd,or time out or other fail reasons
#
#  Description:
#
#
#############################################################

sub connect_telnet{
	my $pkg=shift;
	my $r_input=shift;
	my $connect_hdl=shift;
        my %input=%$r_input;

        my $hostname=$input{'Nename'};
        my $username=$input{'Username'};
        my $passwd=$input{'Password'};
	my $time_out=$input{'timer'};

        my $error_hdl = $pkg->{'ErrMessage_hdl'};

	if($connect_hdl==0){
		$telnet_hdl=new Net::Telnet (Timeout => 1800, Prompt => '/[\$%#>:]\s*$/');
	}
	else{
		$telnet_hdl=$connect_hdl;
	}
	$err_msg='';
	my $pre_errmode=$telnet_hdl->errmode($r_handle_telnet_error);

        #------------------
        # Set buffer size
        #------------------
        my $max_buffer=20*1024*1024;
        $telnet_hdl->max_buffer_length($max_buffer);	
	$telnet_hdl->input_log("/tmp/input.log");
	$telnet_hdl->dump_log("/tmp/telnet.log");

	#---------------
	# login host
	#---------------
	$telnet_hdl->open(Host=>$hostname,Timeout=>$time_out);
	$telnet_hdl->login($username, $passwd);

	#---------------------------------------
	# Change to CSH , this need modify!!
	#---------------------------------------
	#my @csh = $telnet_hdl->cmd("which csh");

	#if ($csh[0] =~ /csh/) {
	#	DBIs::Trace("Change to CSH !\n");
	#	chomp($csh[0]);
	#	DBIs::Trace("CMD: $csh[0]\n");
	#	$telnet_hdl->cmd("$csh[0]");
	#}
	$telnet_hdl->errmode($pre_errmode);	
	if(!$err_msg){
		return (1,"telnet success",$telnet_hdl);
	}
	if($err_msg=~/bad name or password/){
		if ($error_hdl) {
			my $log_info = $err_msg." || Host:$hostname || User:$username || Passwd:$passwd";	
			my $re_code=$pkg->write_dallog($log_info,'','2101');
			if ($re_code<0) { 
				DBIs::Trace("Can't send Warning Message\n",1);
			}
			$err_msg=$err_msg."\n\tFile:".__FILE__."\n\tLine:".__LINE__."\n";
		}
		DBIs::Trace("telnet connect bad name or password error\n",1,1030201,$pkg->{'task_id'});
		return(-1,$err_msg);
	}
	if($err_msg=~/time\-out/){
		if ($error_hdl) {
			my $log_info = $err_msg." || Host:$hostname || User:$username || Passwd:$passwd";	
			my $re_code=$pkg->write_dallog($log_info,'','2102');
                       	if ($re_code<0) {
                               	DBIs::Trace("Can't send Warning Message\n",1);
			}
			$err_msg=$err_msg."\n File:".__FILE__."\t Line:".__LINE__."\n";
		}
		DBIs::Trace("telnet connect timeout\n",1,1030202,$pkg->{'task_id'});
		return (-1,$err_msg);
	}else{
		if ($error_handle) {
			my $log_info = $err_msg." || Host:$hostname || User:$username || Passwd:$passwd";
			my $re_code=$pkg->write_dallog($log_info,'','2199');
			if ($re_code<0) {
				DBIs::Trace("Can't send Warning Message\n",1);
			}
			$err_msg=$err_msg."\n File:".__FILE__."\t Line:".__LINE__."\n";
		}
		DBIs::Trace("telnet connect error\n",1,1030202,$pkg->{'task_id'});
		return (-1,$err_msg);
	}
		
}

##############################################################
#
#  Function:connect_socket
#
#  Input:a ref of a hash which contains information for socket.
#	 This hash has following structure:
#	 'socket inf'=>{
#			IP=>hostname or hostip
#			Port=>socket_port
#			timer=>time_out
#			}
#
#  Output:
#
#  Return value:(1,telnet success,$socket_hdl) success,
#		(-1,$err_msg) connect fail,
#
#  Description:
#
#
#############################################################
sub connect_socket{
	my $pkg=shift;
	my $r_input=shift;
        my %input=%$r_input;
 
        my $host=$input{'IP'};
	my $port=$input{'Port'}; 
	my $time_out=$input{'timer'};
	print "host=$host \n";
	print "port=$port \n";

        my $error_hdl = $pkg->{'ErrMessage_hdl'};

	$socket_hdl=new Net::Telnet (Timeout => 1800,Prompt => '/[\$%#>] $/');
	$err_msg='';
	my $pre_errmode=$socket_hdl->errmode($r_handle_socket_error);
	#$socket_hdl->input_log("/tmp/input.log");
	$socket_hdl->dump_log("/tmp/socket.log");

	$socket_hdl->open(Host => $host, Port => $port,Timeout =>$time_out );

	#	print $socket_hdl->get(Timeout=>$time_out),"\n";

	if(!$err_msg){
		return (1,"socket success",$socket_hdl);}
	else{
		if ($error_hdl) {
			my $log_info = $err_msg." Socket $host $port fail!";
			my $re_code=$pkg->write_dallog($log_info,'','2199');
                       	if ($re_code<0) {
                               	DBIs::Trace("Can't send Warning Message\n",1);
                       	}
			$err_msg=$err_msg."\n File:".__FILE__."\t Line:".__LINE__."\n";
		}
		DBIs::Trace("socket connect error\n",1,1030204,$pkg->{'task_id'});
		return (-1,"$err_msg");
	}
}

##############################################################
#
#  Function:connect_loginNE
#
#  Input:1.handle of socket connection.
#	 2.ref of a hash of login_step, the hash has following structure:
#		{
#			1=>$r_step1_inf,
#			2=>$r_step2_inf,
#			...
#			n=>$r_stepn_inf
#		}
#		where,1,2,...n are login step index.$r_stepi_inf is another
#		ref of hash,which has following structrue:
#		{
#			command=>login command,
#			expect=>symbol expected,
#			except=> mark of except,
#			timer=>time out	
#		}
#	3.output_record_separator.If we don't assign the value of the 
#	  output record separator, Telnet module will append '\n' to each
#	  message being sent.
#
#  Output:
#
#  Return value:(1,last_step_index,"login NE success",$socket_hdl) success, 
# 		(-1 ,step_index,err_msg) failure
#
#  Description:This function login the network element step by step.
#		For each step, it calls function "login_current_step".
#		NOTE: the vaule of 'except' in hash $r_stepi_inf
#		shouldn't be null,otherwise,it will be a defect.
#
#
#############################################################

sub connect_loginNE{
	my $pkg=shift;
	my $socket_hdl=shift;

	my $r_loginNE_inf=shift;
	my $output_record_separator=shift;

	my $last_step_index=1;
	#assign the value of output record separator
	if(defined $output_record_separator){
		$socket_hdl->output_record_separator($output_record_separator);		}

	foreach $step_index (sort {$a <=> $b} keys %$r_loginNE_inf){
	  my($return_code,$return_msg)=login_current_step($socket_hdl,$r_loginNE_inf->{$step_index});
	  $last_step_index=$step_index;

	  #failure
	  if($return_code==-1){return (-1,$step_index,$return_msg);}
	}
	
	#loginNE success
	return (1,$last_step_index,"login NE success",$socket_hdl);	
}

sub login_current_step{
	my $socket_hdl=shift;
	my $r_loginNE_step_inf=shift;

	my $cmd_line=$r_loginNE_step_inf->{'cmd'};
	my $expect=$r_loginNE_step_inf->{'expect'};
	my $except=$r_loginNE_step_inf->{'except'};
	my $time_out=$r_loginNE_step_inf->{'timer'};

	if((!$except)and ($except!~'0')){$except='DEFAULT_ERROR';}

	if(ref($socket_hdl) ne "Net::Telnet"){
		my $err_msg="invalid connect_hdl\n File:".__FILE__."\t Line:".__LINE__."\n";
		return (-1,$err_msg);
	}

	my $pre_errmode=$socket_hdl->errmode($r_handle_loginNE_error);
	$err_msg='';
	
	sleep(1);
	
	$socket_hdl->print($cmd_line);
#	print "---------------\n";
#	print "send: ",$cmd_line,"\n";

	my ($cmd_result_msg,$match)=$socket_hdl->waitfor(Match=>"/($expect|$except)/",Timeout=>$time_out);
#	print "current expect is $expect.\n";
	$socket_hdl->errmode($pre_errmode);

#	print "receive: ",$cmd_result_msg.$match,"\n";
#	print "err_msg is $err_msg \n";

	if($err_msg){
		$err_msg=$err_msg."\n File:".__FILE__."\t Line:".__LINE__."\n";
		return (-1,$err_msg);
	}
	else {
		if($cmd_result_msg=~/$except/){
			$err_msg=$match."\n File:".__FILE__."\t Line:".__LINE__."\n";
			return (-1,$err_msg);}
		else{
			return (1,"success:$cmd_line \n");
		}
	}

}

sub connect_sie8_socket {
	my $pkg=shift;
        my $r_input=shift;
        my $connect_hdl=shift;
        my %input=%$r_input;

        my $host =$input{'Host'};
        my $port =$input{'Port'};
        my $username=$input{'Username'};
        my $passwd=$input{'Password'};
        my $time_out=$input{'timer'};
	my ($telnet_hdl,$cmd_result_msg,$match);
print Dumper(\%input);
        if($connect_hdl==0){
                $telnet_hdl=new Net::Telnet (Timeout => 1800, Prompt => '/[\$%#>:]\s*$/');
        }
        else{
                $telnet_hdl=$connect_hdl;
        }
	$telnet_hdl->input_log("/tmp/input.log");
        $telnet_hdl->dump_log("/tmp/socket.log");
        $telnet_hdl->open(Host => $host, Port => $port,Timeout =>$time_out );
print Dumper($telnet_hdl);
print "host: $host port: $port \n";
print "$username 8\n";
$time_out=10;
	$telnet_hdl->print("$username");
	($cmd_result_msg,$match)=$telnet_hdl->waitfor(Match=>"/PLEASE ENTER CURRENT PASSWORD/",Timeout=>$time_out);
	print "$cmd_result_msg"."$match";
print "1234..";
	($cmd_result_msg,$match)=$telnet_hdl->waitfor(Match=>"/AND OPTIONALLY A NEW ONE SEPARATED BY BLANK/",Timeout=>$time_out);
	print "$cmd_result_msg"."$match";

	$telnet_hdl->print("$passwd");
	my ($cmd_result_msg,$match)=$telnet_hdl->waitfor(Match=>"/SESSION REQUEST ACCEPTED/",Timeout=>$time_out);
	print "$cmd_result_msg"."$match";
	my ($cmd_result_msg,$match)=$telnet_hdl->waitfor(Match=>"/</",Timeout=>10);
	print "$cmd_result_msg"."$match";

	return (1,"connect socket success",$telnet_hdl);
}

1;
