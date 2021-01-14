#!/opt/dc_perl/bin/perl
######################################################
#Name: Gen_task 
#Writer : jiaxiaolong DC Group
#Modify :
#(1) 2004-02-18 add mysql  & oracle  support
######################################################

use strict;
use warnings;
use Env qw(NPM_HOME  LDAP_SERVER LDAP_NPM_BASE LDAP_MD_BASE LDAP_DSN_BASE);
use lib "$NPM_HOME/common/modules";
use Msg;
use XML::Simple;
use Data::Dumper;
use Proc::Daemon;
use FileHandle;
use Getopt::Long;
use DBI;
use Time::Local;
use Net::Telnet;
use IPC::SysV qw(IPC_PRIVATE IPC_RMID IPC_CREAT S_IRWXU IPC_NOWAIT);
use IPC::Msg;
use IPC::Semaphore;
use LDAP_API;


#main start

my ($ELEMENT,$CHAR,%ATTR,$ACT_NO);
my ($conn, $msg, $err);
my $daemon_flag=1 ;
my %opts ;

if($ARGV[0] eq '-v'){
	print "\nGen_task 1.0 For NPM 1.0 \n";
	print "	\nSupport 	DataCheck \n";
	print "\n		sync_pm \n";
	print "	\n		call_db_middle collector \n";
	print "	\n		BOCO Ltd. \@2003 \n";
	exit ;
}

if($ARGV[0] eq '-h'){
	print "Gen_task 1.0 For NPM 1.0 \n";
	print "Usage: 	\'Gen_task.pl -w \' --show Debug info,close Daemon\n";
	print "	\'Gen_task.pl -k \' --kill all Gen_task\n";
	print "	\'Gen_task.pl -v \' --show version\n";
	print "	\'Gen_task.pl -h \' --show This Information\n";
	exit ;
}

&kill_other;

if($ARGV[0] eq '-k'){
	exit ;
}


if($ARGV[0] eq '-w'){
	$daemon_flag=0;
	print ("Daemon  Close \n");
}


my $config =&get_config; 

###add for oracle & mysql
my $LOCK_SQL;
my $ISOLATION_SQL;
my $CURRENT;
my $INTERVAL;



###add by zhouw  20050908
my $sem_key = 654321 ;
if( defined($config->{'md'}->{'sem_key'}) ){
    $sem_key = $config->{'md'}->{'sem_key'} ;
}


my $sem = new IPC::Semaphore($sem_key, 2, 0666 | IPC_CREAT );
if( !defined($sem) ){
    print "Create IPC::Semaphore failed !";
    exit(-1);           
}       

#print "task_manager max_num :$config->{'md'}->{'invoker_max_num'}\n" ;
if(!defined($config->{'md'}->{'invoker_max_num'}))
{
        $config->{'md'}->{'invoker_max_num'}=20;
}
$sem->setval( 0 , $config->{'md'}->{'invoker_max_num'} ); 

$sem->setval( 1 ,1 );
###add end

if(uc($config->{'dsn'}->{'db_driver'}) eq 'INFORMIX'){
        $ISOLATION_SQL="set isolation to dirty read ;";         
	$LOCK_SQL="set lock mode to wait 600; ";
        $CURRENT="current";
        #$INTERVAL=" interval(60) minute to minute "; 
        $INTERVAL=" interval(120) minute to minute "; 
}
elsif(uc($config->{'dsn'}->{'db_driver'}) eq 'ORACLE'){
        $CURRENT="sysdate";
        #$INTERVAL=" sysdate-1/24 ";
        $INTERVAL=" sysdate-2/24 ";
}
elsif(uc($config->{'dsn'}->{'db_driver'}) eq 'MYSQL'){
        $CURRENT="now()";
        #$INTERVAL=" interval '1' day_hour  ";
        $INTERVAL=" interval '2' day_hour  ";
}


###add for oracle & mysql

##Send Register message to Task_manager
eval {
	local $SIG{ALRM} = sub { die "TIMEOUT\n" };
	alarm(30);
	&register_to_task_manager;
	alarm(0);  # cancel alarm (if code ran fast)
};
alarm(0);    # cancel alarm (if eval failed)
if ( $@ eq "TIMEOUT\n" ) {
	&printlog("Register to Task Manager TIMEOUT\n");
}

$SIG{CHLD} = 'IGNORE';

my $times=1;
my $msg_times=1;
my $child=fork();
if($child ==0){	##Restart Daemon 
	if($daemon_flag){
		Proc::Daemon::Init;
	}
	sleep 10; 
	while(1) {
		$times++;
		$msg_times++;
		if(($times*$config->{'md'}->{'heartbeat'}) >= $config->{'md'}->{'restart_datacheck_time'}){
			&printlog("sleep DataCheck Restart Begin\n","Restart");
			eval {
				local $SIG{ALRM} = sub { die "TIMEOUT\n" };
				alarm(30);
				&restart_datacheck;
				alarm(0);  # cancel alarm (if code ran fast)
			};
			alarm(0);    # cancel alarm (if eval failed)
			if ( $@ eq "TIMEOUT\n" ) {
				&printlog("restart_datacheck TIMEOUT\n");
			}
			$times=1;
		}
		if(($msg_times*$config->{'md'}->{'heartbeat'}) >600)
		{
			my $msg_flag=$sem->getval(1);
			eval {
				local $SIG{ALRM} = sub { die "TIMEOUT\n" };
				alarm(3600);
				&readfile2msg($msg_flag);
				alarm(0);  # cancel alarm (if code ran fast)
			};
			alarm(0);    # cancel alarm (if eval failed)
			if ( $@ eq "TIMEOUT\n" ) {
				&printlog("READ MSG TIMEOUT\n");
			}
   			$msg_flag=1-$msg_flag;
   			$sem->setval(1,$msg_flag);
			$msg_times=1;
		}
		eval {
			local $SIG{ALRM} = sub { die "TIMEOUT\n" };
			alarm(30);
			&HeartBeat_to_task_manager;
			alarm(0);  # cancel alarm (if code ran fast)
		};
		alarm(0);    # cancel alarm (if eval failed)
		if ( $@ eq "TIMEOUT\n" ) {
			&printlog("restart_datacheck TIMEOUT\n");
		}
		

	   	sleep $config->{'md'}->{'heartbeat'};
   	
	}
	exit 0;
}
else { 
	$SIG{CHLD} = 'IGNORE';
		$child=fork();
		if($child ==0){	##Task manager Daemon 
			if($daemon_flag){
				Proc::Daemon::Init;
			}
			my $dumper_ldap=Dumper($config);
			&printlog("LDAP DUMPER: $dumper_ldap");
			sleep 1;
			&resume_task;
			&Task_manager;
			exit 0;
		}
		else { ##Msg server Daemon
			if($daemon_flag){
				Proc::Daemon::Init;
			}
			Msg->new_server($config->{'md'}->{'md_name'}, $config->{'md'}->{'gen_task_port'}, 
				\&login_proc) || die "Can not create server\n";
			&printlog("#####################################################\n","Main");
			&printlog("Server created. Waiting for events...\n","Main");
			&printlog("#####################################################\n","Main");
			Msg->event_loop();
		}

}
1;

#main stop

#---------------------------------------------------------------
sub login_proc {
	# Unconditionally accept an incoming connection request
	return \&rcvd_msg_from_client;
}


sub rcvd_msg_from_client {
	($conn, $msg, $err) = @_;
	eval {
		local $SIG{ALRM} = sub { die "TIMEOUT\n" };
		alarm(5);
		my $pid=fork();
                if ($pid == 0 ) {
                        my $pid=fork();
                        if ($pid == 0 ) {
                                &process_msg($conn,$msg,$err);
                                exit 0;
                        }
                        exit 0;
                }
                wait();
                alarm(0);  # cancel alarm (if code ran fast)

	};
	alarm(0);    # cancel alarm (if eval failed)
	if ($@) {
		&printlog("Socket Server  $@\n");
	}

}

sub process_msg {
	my ($conn, $msg, $err) = @_;
	my $re_msg;
	if (defined $msg) {
		chomp $msg;
		if ($msg eq ''){ 
			return -1;
		}
		&printlog("$msg\n","Receive Socket Msg");
		my $msg_hash = eval { XMLin($msg) };
		if ($@) {
			&printlog("msg xml parser  Error ".$msg."  \n","Receive Socket Msg");
			return -1;
		}
		
		if ( $msg_hash->{'SendMsg'}->{'trans_code'} eq "D0" ){  ### DataCheck Register 
			eval("\$re_msg=\&register(\$msg_hash);");
			&printlog("$re_msg\n","Register return msg");
			$conn->send_now($re_msg);
		}
		elsif ( $msg_hash->{'SendMsg'}->{'trans_code'} eq "D1" ){  ### DataCheck HeartBeat 
			$conn->send_now("ok");
			eval("\$re_msg=\&HeartBeat(\$msg_hash);");
		}
		elsif ( $msg_hash->{'SendMsg'}->{'trans_code'} eq "D2" ){  ### DataCheck DcTask 
			eval("\$re_msg=\&DcTask(\$msg_hash);");
			if($re_msg == 0){
				$conn->send_now("ok");
			}
			else {
				$conn->send_now("bad");
			}
		}
		elsif ( $msg_hash->{'SendMsg'}->{'trans_code'} eq "D3" ){  ### Recollect Task
			$conn->send_now("ok");
			eval("\$re_msg=\&Recollect(\$msg_hash);");
		}
		elsif ( $msg_hash->{'SendMsg'}->{'trans_code'} eq "D6" ){  ###Sync PM trigger by adaptor
			$conn->send_now("ok");
			eval("\$re_msg=\&Sync_pm(\$msg_hash);");
		}
		elsif ( $msg_hash->{'SendMsg'}->{'trans_code'} eq "D5" ){  ###DB APP
			$conn->send_now("ok");
			eval("\$re_msg=\&Db_App(\$msg_hash);");
		}
		else {
			$re_msg="trans_code is null";
			$conn->send_now($re_msg);
			return -2;
		}
	}
}

sub register {
	my $msg_hash=shift;
	my $re_msg;
	my $last_time;
	&printlog("check_id=$msg_hash->{'SendMsg'}->{'check_id'}\tomc_id=$msg_hash->{'SendMsg'}->{'omc_id'}\n","Register");
	$last_time=&register_db($msg_hash);
	$re_msg="<msg> <RecMsg check_id=\'$msg_hash->{'SendMsg'}->{'check_id'}\' omc_id=\'$msg_hash->{'SendMsg'}->{'omc_id'}\' trans_code=\'D0\' last_time=\'$last_time\' /> </msg>";
	return $re_msg ;
}

sub register_db {
	my $msg_hash=shift;
	my @rows;
	my ($sql,$updtime,$dbh,$sth,$omc_id);
	
	$dbh= &connect_db($config);
        $sth = $dbh->prepare("SELECT check_id , omc_id, host_ip, host_user, 
		host_pwd, cmd , last_updtime , flag  FROM dal_datacheck WHERE check_id= ? ");
        $sth->execute( $msg_hash->{'SendMsg'}->{'check_id'} );

        while (@rows = $sth->fetchrow_array ) {
		$updtime=$rows[6];
        }
	my @table_list=split(",",$msg_hash->{'SendMsg'}->{'table_list'});
	my $tab_list="\'$table_list[0]\'";
	for(my $i=1;$i<@table_list;$i++){
		$tab_list .= ",\'$table_list[$i]\'";
	}
	if ( $sth->rows >1 ) { 
		$sth->finish;
		$dbh->disconnect;
		&printlog("Select dal_datacheck return $sth->rows row where check_id=$msg_hash->{'SendMsg'}->{'check_id'}","Register");
		return '';
	}
	elsif ($sth->rows == 1) { ### normal Register
		if($msg_hash->{'SendMsg'}->{'table_list'} ne ''){
			$sql="select min(latest_time) from mapi_time_status 
				where omc_id= 
				\'$msg_hash->{'SendMsg'}->{'omc_id'}\' 
				and  tab_name in ($tab_list)";
		}
		else{
			$sql="select min(latest_time) from mapi_time_status 
				where omc_id=\'$msg_hash->{'SendMsg'}->{'omc_id'}\' ";
		}
		$sth = $dbh->prepare($sql);
		$sth->execute();
		@rows = $sth->fetchrow_array  ;
		if (defined $rows[0] ) {
			$updtime=$rows[0];
		}
		$sth->finish;

		$sql="$LOCK_SQL
                      update dal_datacheck set last_updtime=$CURRENT,check_history=0
                      where check_id =\'$msg_hash->{'SendMsg'}->{'check_id'}\'";
                &printlog("SQL: $sql ","Register");
                $dbh->do($sql) ;

		$dbh->disconnect;
		return $updtime;
	}
	else { ### First Register
		my $current=&CFtime("YYYY-MM-DD hh");
		$current=$current.":00:00";
		my $invoker_cmd=$msg_hash->{'SendMsg'}->{'invoker_cmd'};
		$sql="$LOCK_SQL INSERT INTO dal_datacheck 
			(check_id,omc_id,host_ip,host_user,host_pwd,cmd,invoker_cmd,last_updtime,flag)
		VALUES(\'$msg_hash->{'SendMsg'}->{'check_id'}\',\'$msg_hash->{'SendMsg'}->{'omc_id'}\',
		\'$msg_hash->{'SendMsg'}->{'ip'}\',\'$msg_hash->{'SendMsg'}->{'user'}\',
		\'$msg_hash->{'SendMsg'}->{'passwd'}\',\'$msg_hash->{'SendMsg'}->{'cmd'}\',
		\'$invoker_cmd\',\'$current\',0)";

		&printlog( "SQL: $sql","Register");
		$dbh->do($sql) || &printlog( "Insert DB error :$dbh->errstr\n","Register");
		$sth->finish;

		if($msg_hash->{'SendMsg'}->{'table_list'} ne ''){
			$sql="select min(latest_time) from mapi_time_status 
				where omc_id=\'$msg_hash->{'SendMsg'}->{'omc_id'}\' 
				and  tab_name in ($tab_list)";
		}
		else{
			$sql="select min(latest_time) from mapi_time_status 
				where omc_id=\'$msg_hash->{'SendMsg'}->{'omc_id'}\' ";
		}
		print "$sql \n";
		$sth = $dbh->prepare($sql);
		$sth->execute();
		@rows = $sth->fetchrow_array  ;
		if (defined $rows[0] ) {
			$current=$rows[0];
		}
		$sth->finish;
		$dbh->disconnect;
		return $current;
	}

}

sub HeartBeat{
	my $msg=shift;
	my ($dbh,$sth);
	
	$dbh=&connect_db($config);
        $sth = $dbh->prepare("$LOCK_SQL Update  dal_datacheck set last_updtime=? WHERE check_id=?");
        $sth->execute( $msg->{'SendMsg'}->{'time'},$msg->{'SendMsg'}->{'check_id'} );
	$sth->finish;
	$dbh->disconnect;
	&printlog( "$msg->{'SendMsg'}->{'check_id'} \n","HeartBeat");
	return $msg ;
}


sub DcTask {
	my $msg=shift;
	my $task_msg;

	$task_msg="<msg> <Task  omc_id=\"$msg->{'SendMsg'}->{'omc_id'}\" check_id=\"$msg->{'SendMsg'}->{'check_id'}\" invoker_cmd=\"$msg->{'SendMsg'}->{'invoker_cmd'}\" start_time=\"$msg->{'SendMsg'}->{'start_time'}\" stop_time=\"$msg->{'SendMsg'}->{'stop_time'}\" ne_list=\"$msg->{'SendMsg'}->{'ne_list'}\"  table_list=\"$msg->{'SendMsg'}->{'table_list'}\" /> </msg>";
	my $msg_retu=&push_task($task_msg);	
	if ($msg_retu != 0) {
		&printlog("send IPC msg fail \t msg_id=$msg_retu \t $task_msg\n","Receive Task");
		return -1;
	}
	&printlog("check_id=$msg->{'SendMsg'}->{'check_id'} \t".
		"omc_id=$msg->{'SendMsg'}->{'omc_id'} \n \t\t 
		 start_time=$msg->{'SendMsg'}->{'start_time'}".
		" \t stop_time=$msg->{'SendMsg'}->{'stop_time'}","Push Task ok");
	return 0 ;
}

sub push_task {
	my $send_msg=shift;
	my $msg;

	$msg = new IPC::Msg($config->{'md'}->{'msg_key'}, 0666|IPC_CREAT);
	print "begin send IPC  msg  \n";
	$msg->snd(1001,$send_msg)||return $msg->id;
	print "send IPC  msg  ok\n";

	return 0;
}


sub restart_datacheck {
        my ($dbh,$sth);
        my $current=&CFtime("YYYY-MM-DD hh:mm:ss");
        my $sleep_time=&GMtime($current,$config->{'md'}->{'datacheck_timeout'});

        $dbh = &connect_db($config);
        $sth = $dbh->prepare("select host_ip,host_user,host_pwd,cmd,check_id  from  dal_datacheck where last_updtime < \'".$sleep_time."\'");
        if(!$sth->execute()) {
                &printlog("DB error:".__LINE__." \n".$dbh->errstr."\n","restart_datacheck");
                return -1;
        }
        while (my  @row = $sth->fetchrow_array ) {
                &printlog("./DataCheck.pl -i \'$row[4]\'\n");
                system("cd $NPM_HOME/common/mbin/datacheck;./DataCheck.pl -i \'$row[4]\' \&");
                &printlog("Restart dataCheck $row[4] \n","restart_datacheck") ;
        }
        $sth->finish;
        $dbh->disconnect;
                                                                                   
}


sub connect_db {
	$config=shift;

	my %attr = (
		PrintError => 1,
		RaiseError => 0,
	);
	my $dbh;
	my $times=1;

###modify  by zhouw  20050908        
	while(1){
		$dbh = eval{ DBI->connect($config->{'dsn'}->{'odbc_dsn'},
					$config->{'dsn'}->{'db_user'}, 
					$config->{'dsn'}->{'db_pwd'},\%attr) ; };
		if( !defined($dbh) ){			
			&printlog("Can't connect :$DBI::errstr ,retrying............");
			if($times >=3 ){ return undef ;}		
			$times +=1;
			sleep(5);
         }else{
            last;
         }   
    }            
###modify end
      
	return $dbh;


}

sub printlog {
	my $msg=shift;
	my $module=shift;
	my $logfile=shift;

	if(!defined $logfile){
		$logfile = $config->{'md'}->{'gen_task_log'};
	}
	my $dir       = "$NPM_HOME/trace/Gen_task";
	if (!-e $dir)
	{
	    unless (mkdir($dir,0755))
	    {
		print "Err: Create trace directory --$dir failed because of $^E\n";
		exit 0;
	    }
	}
        my $logfd = new FileHandle(">>".$logfile) || warn "can not open log file $logfile\n";
        my $date=&CFtime("YYYY-MM-DD hh:mm:ss");
	print $logfd "[".$date."] [ ".$module."]  ".$msg."\n";
	print "[".$date."] [ ".$module."]  ".$msg."\n";
}


sub kill_other {
	my $pid_list =`ps -ef|grep Gen_task |echo   \`awk '{print \$2}'\``;

	my @pid=split(" ",$pid_list);
	for (my $i=0;$i<@pid;$i++) {
		if ( $pid[$i] != $$ ) {
			`kill -9 $pid[$i] >/dev/null 2> /dev/null `
		}
	}
}


sub Task_manager{
	my $msg;
	my $msg_rec;
	my @Threads;


	$SIG{CHLD} = 'IGNORE';
	my $invoker_num=1;
	while(1){
		eval{
			$msg = new IPC::Msg($config->{'md'}->{'msg_key'}, 0666|IPC_CREAT);
			while ($msg->rcv($msg_rec,4096,0,IPC_NOWAIT)){
				if($msg_rec eq ''){next;}
				&printlog("$msg_rec \n","Receive IPC Msg");
				my $msg_hash = eval { XMLin($msg_rec) };

####modify by zhouw 20050908
				if( $@ ) {
            				&printlog("Error: msg xml parser  Error ".$msg."  \n","Task_manager");      
            				next;
        			}
	
				$sem->op(0,-1,0);			
				my $pid=fork();
    		
    		    		if( !defined($pid) ) {          
    		        		&printlog("Error: fork1 failed !!!  \n","Task_manager");
#    		        		my $msg = new IPC::Msg($config->{'md'}->{'msg_key'}, 0666|IPC_CREAT);
#    		        		if( !defined($msg) ){            
#    		            			&printlog("Error: Can't connect IPC::Msg now !!!  \n","Task_manager");
#    		        		}else{
#    		            			$msg->snd(1001,$msg_rec) ; 
#    		            			&printlog( "Send back IPC Msg : $msg_rec !!!  \n","Task_manager"); 
#    		        		} 
					my $msg_flag=$sem->getval(1);
        				&writemsg2file($msg_rec,$msg_flag);   
    		        		sleep(10);
    		        		return -1;
    		    		}				
						
				if ($pid == 0 ) {
					my $pid=fork();
							
					if( !defined($pid) ) {          
    		        			&printlog("Error: fork2 failed !!!  \n","Task_manager");
#    		        			my $msg = new IPC::Msg($config->{'md'}->{'msg_key'}, 0666|IPC_CREAT);
#   		        			if( !defined($msg) ){            
#    		            				&printlog("Error: Can't connect IPC::Msg now !!!  \n","Task_manager");
#    		        			}else{
#    		            				$msg->snd(1001,$msg_rec) ; 
#    		            				&printlog( "Send back IPC Msg : $msg_rec !!!  \n","Task_manager"); 
#    		        			}  
        					my $msg_flag=$sem->getval(1);
        					&writemsg2file($msg_rec,$msg_flag);  
    		     				sleep(10);
    		     				exit -1;
    		    			}
							
					if ($pid == 0 ) {
						my $task_flag=&run_task($msg_hash);
						if($task_flag == -2)
						{
							sleep 2;
#							my $msg = new IPC::Msg($config->{'md'}->{'msg_key'}, 0666|IPC_CREAT);
#    		        				if( !defined($msg) ){            
#    		           		 			&printlog("Error: Can't connect IPC::Msg now !!!  \n","Task_manager");
#    		        				}else{
#    		            					$msg->snd(1001,$msg_rec) ; 
#    		            					&printlog( "Send back IPC Msg : $msg_rec !!!  \n","Task_manager"); 
#    		        				}  
							my $msg_flag=$sem->getval(1);
       				 			&writemsg2file($msg_rec,$msg_flag);
						}
						$sem->op(0,1,0);
						exit 0;
					}
					exit 0;
				}
				else {
					my $val=$sem->getval(0);
					my $invoker_num = $config->{'md'}->{'invoker_max_num'}-$val;
					while ($invoker_num == $config->{'md'}->{'invoker_max_num'} ) {
						&printlog("invoker max num,waitting .. $invoker_num", "Task_manager");
						sleep 5;
						$val=$sem->getval(0);
						$invoker_num = $config->{'md'}->{'invoker_max_num'}-$val;
					}
					&printlog("Invoker Number: $invoker_num \n");
				}
			}
			sleep 1;
		};
		if ($@) {
			&printlog("Error in Task manager loop:$@");		
			
		}
		
###modify end
	}
}

sub waitforchild {
	my $pid=shift;
	do {
		$pid=waitpid -1,'WNOHANG';
	}until($pid == -1);
}

sub run_task {
	my $msg_hash=shift;
	my ($sth,$command,$dbh);


	my $dbh=&connect_db($config);
	if(!$dbh)
	{	
			return -2;	
	}
	
	my $invoker_cmd=$msg_hash->{'Task'}->{'invoker_cmd'};

	#Check the same Check_id running task is timeout  ?
	my $upd_sql="update dal_task  set run_flag=-1
			where timestamp < $CURRENT-$INTERVAL 
			and check_id = \'$msg_hash->{'Task'}->{'check_id'}\'
			and run_flag=0 ";
	
###modify by zhouw 20050908
	if(!$dbh->do($upd_sql))
	{
			&printlog("DB error:".__LINE__." \n".$upd_sql."\n".$dbh->errstr."\n","update_task");		
			return -2;
	}
###modify end
	my $check_sql ="select count(*) from dal_task  where       
			 start_time= \'$msg_hash->{'Task'}->{'start_time'}\' 
			 and stop_time= \'$msg_hash->{'Task'}->{'stop_time'}\' 
			 and check_id= \'$msg_hash->{'Task'}->{'check_id'}\' 
			and ne_list=\'$msg_hash->{'Task'}->{'ne_list'}\' 
			and table_list = \'$msg_hash->{'Task'}->{'table_list'}\' ";

	my $check=$dbh->prepare($check_sql);
        if(!$check->execute()){
		&printlog("Task DUP:$check_sql","Check_task");
		&printlog("DB error: ".$dbh->errstr."\n","Run_task");
		return -2;                     ###modify by zhouw 20050908
	}
	my @checks = $check->fetchrow_array  ;
#	if($checks[0] >0){
#		&printlog("Task DUP skip:$check_sql","Check_task");
#		$check->finish;
#		$dbh->disconnect;
#		return -1;
#	}
	$check->finish;
			
	#&printlog("CURRENT=$CURRENT ");

	#insert to dal_task table
	my $sql="$LOCK_SQL 
		insert into dal_task(check_id,invoker_cmd,start_time,stop_time,run_flag,ne_list,table_list,timestamp) 
		values(\'$msg_hash->{'Task'}->{'check_id'}\',
			\'$msg_hash->{'Task'}->{'invoker_cmd'}\',
			\'$msg_hash->{'Task'}->{'start_time'}\',
			\'$msg_hash->{'Task'}->{'stop_time'}\',
			-1,\'$msg_hash->{'Task'}->{'ne_list'}\',
			\'$msg_hash->{'Task'}->{'table_list'}\',$CURRENT)";
	if(!$dbh->do($sql)) {
		&printlog("DB error:".__LINE__." \n".$sql."\n".$dbh->errstr."\n","insert_task");		
		return -2;                    ###modify by zhouw 20050908
	}

	####if no any same check_id invoker process ,run it now! 
        my $sth=$dbh->prepare("select * from dal_task 
				where  run_flag= 0  
			and check_id= \'$msg_hash->{'Task'}->{'check_id'}\' 
				");
        if(!$sth->execute()){
		&printlog("DB error: ".$dbh->errstr."\n","Run_task");
		return -1;
	}
	my @rows = $sth->fetchrow_array  ;
	if (!defined $rows[0] ) {  ### no exist the same check_id other task running
		$sth->finish;
		my $task_id=&get_task_id($dbh,$msg_hash->{'Task'}->{'check_id'},
			$msg_hash->{'Task'}->{'start_time'},
			$msg_hash->{'Task'}->{'stop_time'},
			$msg_hash->{'Task'}->{'ne_list'},
			$msg_hash->{'Task'}->{'table_list'},-1);
		my $old_task_id=$task_id;
		##run this task now 

		$command=&make_cmd($invoker_cmd,
			$msg_hash->{'Task'}->{'start_time'},
			$msg_hash->{'Task'}->{'stop_time'},
			$task_id,
			$msg_hash->{'Task'}->{'ne_list'},
			$msg_hash->{'Task'}->{'table_list'},
			$msg_hash->{'Task'}->{'check_id'},
			$msg_hash->{'Task'}->{'omc_id'});

		&system_log($command);
		&printlog("run command : $command","Run_task");

		my $upd_flag="$LOCK_SQL 
			update  dal_task set run_flag=0 
			where task_id =$task_id";
		if(!$dbh->do($upd_flag)){
			&printlog("error line :".__LINE__." \n".$upd_flag."\n".$dbh->errstr."\n","Run_task");
			return -1;
		}
		&run_cmd($command,$msg_hash->{'Task'}->{'check_id'},
			$msg_hash->{'Task'}->{'start_time'},
			$msg_hash->{'Task'}->{'stop_time'},
			$msg_hash->{'Task'}->{'ne_list'},
			$msg_hash->{'Task'}->{'table_list'},
			$task_id,0,$dbh
			);


		#Check  exists the same check_id in dal_task ,if have ,run it 
		my $check_task="select check_id ,invoker_cmd,start_time,
					stop_time,ne_list,table_list,task_id
			from dal_task where run_flag=-1 
			and check_id =\'$msg_hash->{'Task'}->{'check_id'}\' 
			order by  start_time desc";

		my $sth=$dbh->prepare($check_task);
		
		my $iRowsCount = 0;
		do
		{
			if(!$sth->execute()) {
				&printlog("error line:".__LINE__." \n".$dbh->errstr."\n","Run_task");
				return -1;
			}
			$iRowsCount = $sth->rows;
			&printlog("There are $iRowsCount rows to run!","Run_Task_Count");
			if($iRowsCount>0)
			{
				my @rows = $sth->fetchrow_array;
				my $check_id =$rows[0];
				my $invoker_cmd =$rows[1];
				my $start_time =$rows[2];
				my $stop_time =$rows[3];
				my $ne_list =$rows[4];
				my $table_list =$rows[5];
				if ($ne_list =~ /(\S+)\s*/){
					$ne_list=$1;
				}
				elsif ($ne_list =~ /\s*/){
					$ne_list='';
				}
                        	
				my $task_id_next=$rows[6];
                        	
				my $command=&make_cmd($invoker_cmd,$start_time,
						$stop_time,$task_id_next,$ne_list,
						$table_list,$check_id,
						$msg_hash->{'Task'}->{'omc_id'});
                        	
				&system_log("$command ");
				&printlog("$command","Run_Next_Task");
				
				my $upd_flag="$LOCK_SQL  
					update  dal_task set timestamp=$CURRENT 
					where task_id =$task_id_next";
				if(!$dbh->do($upd_flag)){
					&printlog("error line :".__LINE__." \n".$upd_flag."\n".$dbh->errstr."\n","Run_task");
					return -1;
				}
				
				#&run_cmd($command,$check_id, $start_time,
				#	$stop_time,$ne_list,$table_list,$task_id_next,
				#	1,$dbh);
				&run_cmd($command,$check_id, $start_time,
					$stop_time,$ne_list,$table_list,$task_id_next,
					0,$dbh);
				
				my $upd_flag="$LOCK_SQL  
					update  dal_task set run_flag=1 
					where task_id =$task_id_next";
				if(!$dbh->do($upd_flag)){
					&printlog("error line :".__LINE__." \n".$upd_flag."\n".$dbh->errstr."\n","Run_task");
					return -1;
				}
			}
			
		} until($iRowsCount <= 0);
		$sth->finish;

		my $upd_flag="$LOCK_SQL  
			update  dal_task set run_flag=1 
			where task_id =$old_task_id";
		if(!$dbh->do($upd_flag)){
			&printlog("error line :".__LINE__." \n".$upd_flag."\n".$dbh->errstr."\n","Run_task");
			return -1;
		}
	}
	$dbh->disconnect;
	return 0;
}

sub resume_task {
		my $dbh=&connect_db($config);
#        $dbh->do("update dal_task set run_flag =-1 where run_flag =0");
		$dbh->do("update dal_task set run_flag =-1 where run_flag =0 or result is null");      ###modify by zhouw 20050910
		$dbh->disconnect;
}


sub system_log {
	my $invoker_cmd=shift;
	my $logfile=shift;
	if(!defined $logfile){
		$logfile = $config->{'md'}->{'task_log'};
	}
        my $logfd = new FileHandle(">>".$logfile) || warn "can not open log file $logfile\n";
	print $logfd $invoker_cmd."\n";
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

sub run_cmd {
	my $command=shift;
	my $check_id=shift;
	my $start_time=shift;
	my $stop_time=shift;
	my $ne_list=shift;
	my $table_list=shift;
	my $task_id=shift;
	my $flag=shift;
	my $dbh=shift;

	my $sql = "$LOCK_SQL 
                  update dal_task set run_flag=$flag
                  where  task_id=\'$task_id\'";
	$dbh->do($sql);
	&printlog("[rum cmd]   $sql  \n");
	my $retu=system("$command");
	$sql="select status from dal_instance
                        where task_id  =\'$task_id\'
			and   instance_class=100 ";
	my $sth = $dbh->prepare($sql);
	$sth->execute( );
	my @rows = $sth->fetchrow_array  ;
	if (defined $rows[0] ) {
		$sql = "$LOCK_SQL 
			  update dal_task set 
			  result=\'$rows[0]\' 
			  where  task_id=\'$task_id\'";
		$dbh->do($sql);
	}
	$sth->finish;
	&printlog("[run cmd]   $sql  $DBI::errstr\n");
	return 0;
}


sub get_task_id {
	my $dbh=shift;
	my $check_id=shift;
	my $start_time=shift;
	my $stop_time=shift;
	my $ne_list=shift;
	my $table_list=shift;
	my $flag=shift;
	
	my $sql="select task_id from dal_task where check_id=\'$check_id\' 
		 and start_time=\'$start_time\' and stop_time=\'$stop_time\' 
		 and  run_flag=\'$flag\'
		 and  ne_list=\'$ne_list\'
		 and  table_list=\'$table_list\' ";
	my $sth = $dbh->prepare($sql);
	$sth->execute( );
	my @rows = $sth->fetchrow_array  ;
	if (defined $rows[0] ) {
		return $rows[0];
	}
	else {
		return -1;
	}
}

sub get_config{
	my $ldap=LDAP_API->new;
	my $retu;

	my $MD=$ldap->get_md_attr();
	my $MDDB=$ldap->get_mddb_attr();
	my $npm=$ldap->get_attr_by_Filter("ou=NPM",$LDAP_NPM_BASE);

	$retu->{'dsn'}=$MDDB;
	$retu->{'md'}=$MD;
	$retu->{'NPM'}=$npm->{'NPM'};

	my $logfile = $retu->{'md'}->{'gen_task_log'};
	$logfile=~ /(\S+)\/server.log/;
	system("mkdir -p  $1");
	return $retu;

}

########################################################################
#Send Ask msg to Task_manager For Sync The PM Data Between MDDB <--> NPMDB
#input
#       (1) msg handler
#Return : NULL
########################################################################
sub  Sync_pm {
	my $msg=shift;
	my $sync_msg_result;
	if(defined($msg->{'SendMsg'}->{'db_name'})){
		my $msg_send = "<msg> <SendMsg
				md_name=\'$config->{'md'}->{'mddb_dsn'}\'
				omc_list=\'$msg->{'SendMsg'}->{'omc_id'}\'
				table_list=\'$msg->{'SendMsg'}->{'table'}\'
				start_time=\'$msg->{'SendMsg'}->{'start_time'}\'
				stop_time=\'$msg->{'SendMsg'}->{'stop_time'}\'
				db_name=\'$msg->{'SendMsg'}->{'db_name'}\'
				trans_code=\'D4\'  />
				</msg>";
		$sync_msg_result=&send_msg_to_task_manager($msg_send);
		if($sync_msg_result eq "")
		{
				
		}
		
		&printlog("[Sync_pm]  \n $msg_send  \n");
	}
	else{
		my $msg_send = "<msg> <SendMsg
				md_name=\'$config->{'md'}->{'mddb_dsn'}\'
				omc_list=\'$msg->{'SendMsg'}->{'omc_id'}\'
				table_list=\'$msg->{'SendMsg'}->{'table'}\'
				start_time=\'$msg->{'SendMsg'}->{'start_time'}\'
				stop_time=\'$msg->{'SendMsg'}->{'stop_time'}\'
				trans_code=\'D4\'  />
				</msg>";
		$sync_msg_result=&send_msg_to_task_manager($msg_send);
		&printlog("[Sync_pm]  \n $msg_send  \n");		
	}
}

########################################################################
#Run ReCollect Task
#input
#       (1) msg handler
#Return : NULL
########################################################################
sub Recollect {

}



########################################################################
#Send Msg to Task_manager For call  DB APP 
#input
#       (1) msg handler
#Return : NULL
########################################################################
sub Db_App {
	my $msg=shift;

	my $msg_send = "<msg> <SendMsg
			omc_list=\'$msg->{'SendMsg'}->{'omc_list'}\'
			table_list=\'$msg->{'SendMsg'}->{'table_list'}\'
			start_time=\'$msg->{'SendMsg'}->{'start_time'}\'
			stop_time=\'$msg->{'SendMsg'}->{'stop_time'}\'
			trans_code=\'D5\'  />
			</msg>";
	&send_msg_to_task_manager($msg_send);
	&printlog("[DB_APP]  \n $msg_send  \n");

}



########################################################################
#send msg to task manager
#input
#       (1) msg handler
#       (2) module name
#Return : receive msg handler
########################################################################
sub send_msg_to_task_manager {

        my $msg_send=shift;
        my $module=shift;

        my $conn = Msg->connect($config->{'NPM'}->{'task_manager_ip'}, 
			$config->{'NPM'}->{'task_manager_port'});
 
###modify by zhouw 20050910 
 if (!$conn) {
                my $i=50;
                while($i) {
                        $conn = Msg->connect($config->{'NPM'}->{'task_manager_ip'},
                                                $config->{'NPM'}->{'task_manager_port'});
                        if ($conn) {
                                last;
                        }
                        else {
                                &printlog( "[Error $i]: Could not connect $config->{'NPM'}->{'task_manager_ip'} : $config->{'NPM'}->{'task_manager_port'}\n") ;
                                $i--;
                                sleep 5;
                        }
                }
        }
        if (!$conn) {
                &printlog( "retry failed\n");
                return ''  ;
        }
&printlog( "==================\n");
###modify end

        $conn->send_now($msg_send);
        my ($msg_rec, $err) = $conn->rcv_now();
		&printlog("Receive Socket Msg is $msg_rec\n","Ask For Task_manager");
        if ( $err) {
                &printlog("[$module Error]  from Server:$err\n");
                return ''  ;
        }

#        if($msg_rec eq '') {
#                &printlog("[$module Error] Receive Msg is NULL\n");
#                return ''  ;
#        }


###modify by zhouw 20050910        
        if($msg_rec eq '') {
                my $kk=10;
                &printlog("[$module Error] Receive Msg is NULL\nretry $kk\n");
                sleep 5;
                while($kk){
                        my $conn = Msg->connect($config->{'NPM'}->{'task_manager_ip'},
                                $config->{'NPM'}->{'task_manager_port'});
                        if (!$conn) {
                                my $i=50;
                                while($i) {
                                        $conn = Msg->connect($config->{'NPM'}->{'task_manager_ip'},
                                                $config->{'NPM'}->{'task_manager_port'});
                                        if ($conn) {
                                                last;
                                        }
                                        else {
                                                &printlog( "[Error $i]: Could not connect $config->{'NPM'}->{'task_manager_ip'} : $config->{'NPM'}->{'task_manager_port'}\n") ;
                                                $i--;
                                                sleep(5);
                                        }
                                }
                        }
                        if (!$conn) {
                                &printlog( "retry failed\n");
                                return ''  ;
                        }
                        $conn->send_now($msg_send);
                        my ($msg_rec, $err) = $conn->rcv_now();
                        &printlog("Receive Socket Msg is $msg_rec\n","Ask For Task_manager");
                        if ( $err) {
                                &printlog("[$module Error]  from Server:$err\n");
                                return ''  ;
                        }
                        if($msg_rec eq '') {
                                &printlog("[$module Error] Receive Msg is NULL\nretry $kk\n");
                                $kk--;
                                sleep 5;
                                next;
                        }
                        return $msg_rec;
                }
                return '';
        }
###modify end

        return $msg_rec;
}


########################################################################
#register Gen_task To Task_manager
########################################################################
sub register_to_task_manager{

        my $msg_send = "<msg> <SendMsg 
				check_id=\'$config->{'md'}->{'mddb_dsn'}\'
				omc_id=\'$config->{'md'}->{'mddb_dsn'}\'
                                trans_code=\'D0\' ip=\'$config->{'md'}->{'md_ip'}\'
                                user=\'$config->{'md'}->{'md_user'}\'
                                passwd=\'$config->{'md'}->{'md_passwd'}\'
                                cmd=\'Gen_task.pl\'
                                invoker_cmd=\'sync_pm.pl\' />
                        </msg>";


        &printlog("[register]  start\n");
        &printlog("Send    Msg : $msg_send \n");
        my $msg_rec=&send_msg_to_task_manager($msg_send,"register");
        &printlog("Receive Msg : $msg_rec \n");
        &printlog("[register]  compelete \n");

        if ($msg_rec eq ''){
                print "Can't connect  Task_manager $config->{'NPM'}->{'task_manager_ip'} :
			$config->{'NPM'}->{'task_manager_port'} . \n";
                return -1 ;
        }
	
}

########################################################################
#HeartBeat  HeartBeat
########################################################################
sub HeartBeat_to_task_manager {
        my $date=&CFtime("YYYY-MM-DD hh:mm:ss");

	my @return=`ps -ef |grep Gen_task.pl|grep -v grep|wc`;
	&printlog("[check Gen_task] @return \n");
	my @rows=split(" ",$return[0]);
	if($rows[0] <3){
		my @return=`ps -ef|grep Gen`;
		&printlog("[Gen_task Error] @return \n");
		my @return=`ptree`;
		&printlog("[Gen_task Error] @return \n");
		my @return=`df -k`;
		&printlog("[Gen_task Error] @return \n");
		my @return=`ps -ef|grep invoker|wc`;
		&printlog("[Gen_task Error] [invoker num] @return \n");
		system("cd $NPM_HOME/common/mbin/gen_task;./Gen_task.pl");
		return  -1;
	}

        my $msg_send = "<msg> <SendMsg
                                check_id=\'$config->{'md'}->{'mddb_dsn'}\'
                                omc_id=\'$config->{'md'}->{'mddb_dsn'}\'
                                trans_code=\'D1\' time=\'$date\' />
                        </msg>";
        &send_msg_to_task_manager($msg_send,"HeartBeat");

}


sub  make_cmd {
	my $invoker_cmd=shift;
	my $start_time=shift;
	my $stop_time=shift;
	my $task_id=shift;
	my $ne_list=shift;
	my $table_list=shift;
	my $check_id=shift;
	my $omc_id=shift;

	my $command ;

	if($command=~ /\-o\s+/){
		$command = "$invoker_cmd  -s \'$start_time\' -e \'$stop_time\' -task_id $task_id";
	}
	else{
		$command = "$invoker_cmd  -o $omc_id -s \'$start_time\' -e \'$stop_time\' -task_id $task_id";

	}
	if (($ne_list ne '')&&($ne_list != ~/\s+/)){
		if ($ne_list =~ /(\S+)\s*/){
			$command .=" -ne_list \'$1\' ";
		}
	}
	if (($table_list ne '')&&($table_list != ~/\s+/)){
		$command .=" -table_list \'$table_list\' ";
	}

	return $command;
}


sub insert_task{
	my ($dbh,$check_id,$invoker_cmd,$start_time, $stop_time,$ne_list,$table_list)=@_;
	

	my $ins_sql="insert into dal_task(check_id,invoker_cmd,
			start_time,stop_time,ne_list,table_list,timestamp,run_flag)
		    	values(\'$check_id\',\'$invoker_cmd\',\'$start_time\',
				\'$stop_time\',\'$ne_list\',\'$table_list\',$CURRENT,0)";	
	$dbh->do($ins_sql);

	my $task_id=&get_task_id($dbh,$check_id,$start_time,$stop_time,
					$ne_list,$table_list,0);

	my $ins_sql="update  dal_task set run_flag=$task_id ,result =0
			where check_id =\'$check_id\'
			and run_flag in (0,-1)
			and invoker_cmd =\'$invoker_cmd\'
			and start_time >=\'$start_time\'
			and start_time <\'$stop_time\'
			and ne_list =\'$ne_list\'
			and table_list =\'$table_list\' ";
	&printlog("$ins_sql \n");
	$dbh->do($ins_sql);
	return $task_id;
}

sub for_test{
	$config->{'md'}->{'task_log'}= "/tmp/wengzy/task.log";
	$config->{'md'}->{'sync_data_dir'}= "/tmp/wengzy/sync";
	$config->{'md'}->{'msg_key'}= 11999;
	$config->{'md'}->{'gen_task_port'}= 11999;
	$config->{'md'}->{'gen_task_log'}= "/tmp/wengzy/gen_task.log";
	$config->{'dsn'}->{'odbc_dsn'}= "dbi:ODBC:test";
	$config->{'dsn'}->{'db_dsn'}= "test";
}

sub task_num{
        my $dbh=&connect_db($config);
        if(!defined $dbh){
                return 0;
        }
        my $sql="select count(*) from dal_task where run_flag=0";
        my $sth = $dbh->prepare($sql);
        $sth->execute();
        my @rows = $sth->fetchrow_array ;
        $sth->finish;
        $dbh->disconnect;
        return $rows[0];
}


sub writemsg2file
{
        my $msg =shift;
        my $file_num=shift;
        my $file_num=1-$file_num;
        &printlog("WRITE MSG TO FILE$file_num START:$msg\n","writemsg2file");
        my $msg_dir = "$NPM_HOME/common/mbin/gen_task/msg";

        if (!-e $msg_dir)
        {
                unless (mkdir($msg_dir,0755))
                {
                        print "Err: Create MSG directory --$msg_dir failed because of $^E\n";
                        exit 0;
                }
        }

        my $msg_file = "$msg_dir/error_msg$file_num";

        my $file_w=new FileHandle(">>".$msg_file) || warn "can not open MSG file $msg_file\n";
        print $file_w $msg."\n";

        close $file_w;
        &printlog("WRITE MSG TO FILE$file_num END:$msg\n","writemsg2file");
}


sub readfile2msg
{
        my $file_num=shift;
        &printlog("READ MSG FROM FILE$file_num START\n","readfile2msg");
        my $msg_file = "$NPM_HOME/common/mbin/gen_task/msg/error_msg$file_num";
        if(!-e $msg_file)
        {
                &printlog("No File :$msg_file\n","readfile2msg");
                return 0;
        }
        else
        {
                my $file_r=new FileHandle($msg_file) || warn "can not open MSG file $msg_file\n";
                my $msg;
                while(my $line = <$file_r>)
                {
                        if($line =~ /\<msg\>/)
                        {
                                $msg =$line;
                                if($msg !~ /\/\> \<\/msg\>/)
                                {
					while($line = <$file_r>)
					{
						$msg .=$line;
						if($line =~ /\/\> \<\/msg\>/)
						{
							last;
						}
						else
						{
							next;
						}
					}
                                }
				if($msg =~ /\/\> \<\/msg\>/)
				{
                                        &printlog( "Send back IPC Msg START: $msg \n","readfile2msg");
                                                                               
                                        my $msg_connect = new IPC::Msg($config->{'md'}->{'msg_key'}, 0666|IPC_CREAT);
    		        		if( !defined($msg_connect) ){            
    		            			&printlog("Error: Can't connect IPC::Msg now !!!  \n","readfile2msg");
    		        		}else{
    		            			$msg_connect->snd(1001,$msg) ; 
    		            			&printlog( "Send back IPC Msg END: $msg !!!  \n","readfile2msg"); 
    		        		}
				}
				else
                                {
                                        &printlog("Error MSG:$msg\n","readfile2msg");
                                }
                                undef($msg);
                                next;
                        }
                        else
                        {
                                next;
                        }
                }
                close $file_r;
                my $rm_file = "rm -f $msg_file";
                &printlog("delete File : $msg_file\n","readfile2msg");
                system($rm_file);
                return 0;
        }
        &printlog("READ MSG FROM FILE$file_num end\n","readfile2msg");
}
