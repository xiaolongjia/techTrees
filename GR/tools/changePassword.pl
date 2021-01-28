#!/usr/local/bin/perl -T

use lib "../libs";
use Users;

if (@ARGV < 3) {
        print("Usage: \n".$0."\t[UserName]    [Old Password]    [New Password]\n");
        exit;
}

my $userID    = $ARGV[0];
my $oldPasswd = $ARGV[1];
my $newPasswd = $ARGV[2];
my $userObj = Users->new(userId => $userID);
$userObj->changePassword($oldPasswd, $newPasswd);
print("Successed to change password!\n");

