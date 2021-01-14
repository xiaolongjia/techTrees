package WriteDallog;

###############################################################################
#
#  @(#) Perl Module: WriteDallog
#
#  Copyright(C) 2002-2004 BOCO Inter-Telecom DC Team, All Rights Reserved
#
#  Author(s): JIA XL
#
#  Creation Date:  2003/01/15
#
#  Last update Date: 2003/02/25
#
#  Description:
#
#
##############################################################################

use strict;

use DBI;
use IO::String;
use XML::Writer;
use Data::Dumper;
use Date::Format;
use MQClient::MQSeries;
use MQSeries::QueueManager;
use MQSeries::Queue;
use MQSeries::Message;

use DBIs;
use LDAP_API;

#######################################################################
#
# Function: new
#
# Input: null
#
# Output:
#
# Description:
#
#######################################################################

sub new {
	my ($type,$common_part) = @_;
	my $self = {};
    	$self->{'mq_handle'}=0; 
    	$self->{'db_handle'}=0; 
    	$self->{'common'}=$common_part; 
    	bless $self, $type;
    	return $self;
}

#######################################################################
#
# Function: connect_MQ
#
# Input: 
#
# Output:
#
# Description: 
#
#######################################################################

sub connect_MQ {
	my ($self,$qmgrname,$requestqname,$mode)=@_;
	
	#-------------------------------
    	# Step one: connect to the queuemanager.
	#-------------------------------
    	my $reason;
    	my $qmgr = MQSeries::QueueManager->new( QueueManager => $qmgrname ) || return -1;

	#---------------------------
    	# Step two: open the dest queue 
	#---------------------------
    	my $connect = MQSeries::Queue->new
    		(
      		QueueManager		=> $qmgr,
      		Queue		=> $requestqname,
      		Mode			=> $mode,
      		Reason                    => \$reason,
     		) || return -1;

     	$self->{'mq_handle'}=$connect;
     
     	return 1;
}

######################################################################
#
# Function: FmtHASH2XML
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub FmtHASH2XML {
	my ($self,$hash_ref) = @_;
	#print "Hash Structure:",Dumper($hash_ref);
        my $xml_str;
        my $output = IO::String->new($xml_str);
        my $write_hdl = XML::Writer->new(
                                OUTPUT => $output,
                                NEWLINES => 1
                        );
        $write_hdl->xmlDecl("gb2312");
        $write_hdl->startTag('Message');
        $self->WriteXmlBody($hash_ref,$write_hdl);
        $write_hdl->endTag('Message');
        $write_hdl->end();
        $output->close();
	#print "\nXML String: $xml_str \n";
        return ($xml_str);
}

######################################################################
#
# Function: WriteXmlBody
#
# Input:
#
# Output:
#
# Description: it's called by sub FmtHASH2XML
#
#######################################################################

sub WriteXmlBody {
        my ($self,$hash_ref,$write_hdl) = @_;
        foreach my $key (keys %$hash_ref) {
                if (ref($hash_ref->{$key})) {
                        $write_hdl->startTag($key);
                        $self->WriteXmlBody($hash_ref->{$key},$write_hdl);
                        $write_hdl->endTag($key);
                }
                elsif ( $key !~ /HASH/ ) {
                        $write_hdl->startTag($key);
                        $write_hdl->characters($hash_ref->{$key});
                        $write_hdl->endTag($key);
                }
        }
	#print "Success to Format HASH2XML \n";
}

#######################################################################
#
# Function: send_MQ
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub send_MQ {
	my ($self,$msg,$msg_type) = @_ ;
	if (!$msg_type) {
		$msg_type =1280;
	}
	$msg_type += 65536;
      	my $sendmsg = MQSeries::Message->new (
		MsgDesc		=> {
			MsgType		=> $msg_type,
		},
       		Data		=> $msg,
      	);

    	#-------------------------- 
      	# send MSG to MQGR queue 
    	#-------------------------- 
     	($self->{mq_handle})->Put(Message => $sendmsg);
      	if((($self->{mq_handle})->CompCode()== &MQCC_OK) || (($self->{mq_handle})->CompCode()== &MQCC_WARNING)) {
		return 1;
	}
      	if(($self->{mq_handle})->CompCode()== &MQCC_FAILED) {
        	print "the reason is ($self->{mq_handle})->Reason()\n";
         	return -1;
      	}

}

#######################################################################
#
# Function: receive_MQ
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub receive_MQ {
	my ($self,$pollrate) = @_ ;
     	my $request = MQSeries::Message->new();
 
    	while(1) {
      		($self->{mq_handle})->Get (
           		Message 	=> $request,
           		Wait	        => $pollrate,
         	);
      
      		if(($self->{mq_handle})->CompCode()== &MQCC_OK || ($self->{mq_handle})->CompCode()== &MQCC_WARNING) {
         		#print "Request: " . $request->Data() . "\n";
         		my $receive_data = $request->Data();
         		return $receive_data;
      		}
      		if(($self->{mq_handle})->CompCode()== &MQCC_FAILED) {
			my $reason = ($self->{mq_handle})->Reason();
         		print "the failed reason:\n",$reason,"\n";
         		if (($self->{mq_handle})->Reason() == &MQRC_NO_MSG_AVAILABLE) {
	    			print "Timed out waiting for requests.  Retrying...\n";
	    			return 0;
         		} 
         		return -1;
      		}
      
    	}

}

#######################################################################
#
# Function: mq_commit
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub mq_commit {
	my ($self) = @_;
    	if((($self->{mq_handle})->Commit())==1) {
       		print "commit the MQ transaction successful\n";
       		return 1;
    	}else{
       		print "commit the MQ transaction failed\n"; 
       		return 0;
    	}
}

#######################################################################
#
# Function: mq_rollback
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub mq_rollback {
	my ($self) = @_;
	if((($self->{mq_handle})->Backout())==1) {
       		print "rollback the MQ transaction successful\n";
       		return 1;
    	}else{
       		print "rollback the MQ transaction failed\n"; 
       		return 0;
    	}
}

#######################################################################
#
# Function: ConnectDb
#
# Input:
#
# Output:
#
# Description:
#
#######################################################################

sub connect_DB {
	my ($self,$db_type,$db_server,$database,$user,$passwd) = @_;

	my $connect_str;
        if ($db_type =~ /informix/i) {
		$db_type='Informix';
                $connect_str = "dbi:$db_type:$database" . "\@$db_server";
        }
        elsif ($db_type =~ /oracle/i) {
		$db_type='Oracle';
                $connect_str = "dbi:$db_type:$db_server";
        }
        my $db_hdl = DBI->connect($connect_str, $user, $passwd);
	my $lock_mode = "set lock mode to wait 60";
	$db_hdl->do($lock_mode);

        if (!$db_hdl) {
                my $err_msg = "Error: Can not connect to database $db_server: $DBI::errstr\n";
                return (-1,$err_msg);
        }

	$self->{'db_handle'} = $db_hdl;

	return 1;
}

#######################################################################
#
# Function: WritelogTbl
#
# Input:
#
# Output:
#
# Description: Get arguments from command line
#

#######################################################################

sub WritelogTbl {
	my ($self,$hash_ref,$table_name) = @_;

	if (!$table_name) {
		$table_name = 'dal_log';
	}
	my $db_hdl = $self->{'db_handle'};

        my (@column,@values);
        my $i=0;
        foreach my $key (keys %$hash_ref) {
                $column[$i] = $key;
                $values[$i] = $hash_ref->{$key};
                $i++;
        }
        my $insert_sql = "insert into $table_name (";
	my $value_str = '';
        for ($i=0;$i<@column;$i++) {
                $insert_sql .= $column[$i].",";
		$value_str  .= "?,";
        }
        chop $insert_sql;
	chop $value_str;
        $insert_sql = $insert_sql.")"." values ($value_str)";
        #print "\n\nWriting log_table SQL:\n\t$insert_sql\n\n";
	my ($r,$str);
        my $sth = $db_hdl->prepare($insert_sql)|| (($r=$DBI::err)&&($str=$DBI::errstr));
        if ($r) {
                $db_hdl->rollback;
                return (-1,"$str");
        }
        for ($i=1;$i<=@values;$i++) {
                my $j = $i-1;
                $sth->bind_param($i,$values[$j]);
        }
        $sth->execute || (($r=$DBI::err) &&($str=$DBI::errstr));
        if ($r) {
                return (-1, "\n$str");
        }

        return (1,"Success\n");
}

sub close {
	my ($pkg) = @_;

	undef($pkg);
	return($pkg);
}


return 1;
