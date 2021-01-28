#!/usr/local/bin/perl

use strict;
use warnings;
 
use Test::More;
use Capture::Tiny qw(capture);
use File::Temp qw(tempdir);
 
plan tests => 5;
 
subtest loginSucess => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=Jack&password=111&action=login';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"success" : "login is successful", "user" : "Jack"}}, 'normal login';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

subtest loginSucessPost => sub {
    plan tests => 3;
    my $params = 'username=Jack&password=111&action=login';
    local $ENV{REQUEST_METHOD} = 'POST';
    local $ENV{CONTENT_LENGTH} = length($params);
    my $dir = tempdir(CLEANUP => 1);
    my $infile = "$dir/$$"."_in.txt";
    open my $fh, '>', $infile or die "Could not open '$infile' $!";
    print $fh $params;
    close $fh;
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi < $infile"};
    like $out, qr{{"success" : "login is successful", "user" : "Jack"}}, 'normal login';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};
 
subtest wrongPassword => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=Jack&password=222&action=login';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"error" : "username or password is wrong"}}, 'wrong password';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

subtest nullUSerName => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=&password=222&action=login';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"error" : "username or password is wrong"}}, 'null username';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

subtest nullPassword => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=Jack&password=&action=login';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"error" : "username or password is wrong"}}, 'null password';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

