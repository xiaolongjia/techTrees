#!/usr/local/bin/perl -T

use Data::Dumper;

use lib "../libs";
use Users;

if (@ARGV < 3) {
        print("Usage: \n".$0."\t[UserName]    [Product Name]    [Price]\n");
        exit;
}

my $userID    = $ARGV[0];
my $product   = $ARGV[1];
my $price     = $ARGV[2];
my $userObj = Users->new(userId=>$userID);
print(Dumper($userObj->writeOrder("SIM Card", "34")));

