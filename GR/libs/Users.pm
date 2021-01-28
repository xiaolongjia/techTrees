package Users; 

use Data::Dumper;
use POSIX qw(strftime);
use Moose;

has 'userId', is => 'ro';

use constant {
	SALT => 'GR',
	PASSWORDFILE => '../data/password.txt',
	ORDERSFILE   => '../data/orders.txt'
};

###############################################################################
#
#  @(#) Perl Module: Users
#
#  Copyright(C) 
#
#  Author(s): Xiaolong Jia
#  
#  Creation Date: 2021/01/26
#
#  Description: This package is to provide some re-used functions: 
#     1. Extract user's password information and change user's password.
#     2. Extract user's historical order information
#     3. others.
###############################################################################

sub openFile {
	my ($self, $filename)=@_;
	if(-e $filename){
		open(READ, "<$filename" ) or die "ERROR:Cann't open file: $filename!\n";
		my @lines = <READ>; #does not work for a huge file (just an example).
		return \@lines;
	} else {
		 die "ERROR: file: $filename does not exist!\n";
	}
}

sub getPassword {
	my $self = shift;
	my $userID = $self->userId;
	my $result = '';
	my $passwdData = $self->openFile(PASSWORDFILE);
	if ($passwdData) {
		for (@$passwdData) {
			my $data = $_;
			chomp($data);
			my @currData = split/,/,$data;
			if ($currData[0] =~ /^$userID$/) {
				$result = $currData[1];
				return $result; # return the existed password for user.
			}
		}
		return 0; # return null string for not existed user. 
	}
	return -1; # for the case of null password file. 
}

sub writePassword {
	my ($self, $data, $mode) = @_;
	my $filename = PASSWORDFILE;
	if ($mode eq 'ow') { #overwrite mode
		$mode = ">";
	} else { # add mode
		$mode = ">>";
	}
	open(WRITE, $mode, $filename ) or die "ERROR: Cann't write file: $filename!\n";
	for (@$data) {
		print WRITE $_;
	}
	close(WRITE);
}

sub changePassword {
	my ($self, $oldPassword, $newPassword)=@_;
	my $userID = $self->userId;
	my $oldPwd = crypt($oldPassword, SALT);
	my $newPwd = crypt($newPassword, SALT);
	my $storedPasswd = $self->getPassword();
	if ($storedPasswd eq 0 or $storedPasswd eq -1) { #add user password into password file.
		my $string = $userID.",".$newPwd."\n";
		$self->writePassword([$string],"a");
	} else { #update password file. 
		if ($storedPasswd eq $oldPwd) {
			my $passwdData = $self->openFile(PASSWORDFILE);
			my @newData = ();
			for (@$passwdData) {
				my $data = $_;
				my @currData = split/,/,$data;
				if ($currData[0] =~ /^$userID$/i) {
					my $string = $userID.",".$newPwd."\n";
					push @newData, $string;
				} else {
					push @newData, $data;
				}
			}
			$self->writePassword(\@newData,"ow");
		} else {
			die "ERROR: old password for user: $userID is incorrecrt!\n";
		}
	}
}

sub getOrders {
	my ($self) = @_;
	my $userID = $self->userId;
	my @result = ();
	my $hashRef = {};
	my $orderData = $self->openFile(ORDERSFILE);
	if ($orderData) {
		for (@$orderData) {
			my $data = $_;
			chomp($data);
			my @currData = split/,/,$data;
			if ($currData[1] eq $userID) {
				$hashRef->{$currData[0]} = [$currData[0],$currData[1], $currData[2],$currData[3],$currData[4]];
			}
		}
		my $counter = 0;
		foreach my $key (sort {$b <=> $a} keys %$hashRef) {
			$counter +=1;
			if ($counter > 10) {
				last;
			} else {
				push @result, $hashRef->{$key};
			}
		}
	}
	return \@result;
}

sub writeOrder {
	my ($self, $product, $price) = @_;
	if (!($self->userId) or !($product) or !($price)) {
		return  0;
	}
	my $date = strftime "%Y-%m-%d", localtime;
        my $filename = ORDERSFILE;
	my $orderData = $self->openFile($filename);
	my @orders = @{$orderData};
	my @data = split/,/,$orders[$#orders];
	my $orderID = $data[0] +1;
	my $string = $orderID.",".$self->userId.",".$date.",".$product.",".$price."\n";
        open(WRITE, ">>", $filename ) or die "ERROR: Cann't write file: $filename!\n";
        print WRITE $string;
        close(WRITE);
	return 1;
}

1;
