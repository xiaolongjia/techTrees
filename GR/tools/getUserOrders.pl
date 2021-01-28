#!/usr/local/bin/perl -T

use Data::Dumper;

use lib "../libs";
use Users;

if (@ARGV < 1) {
        print("Usage: \n".$0."\t[UserName]\n");
        exit;
}

my $userID    = $ARGV[0];
my $userObj = Users->new(userId=>$userID);
print(Dumper($userObj->getOrders()));

