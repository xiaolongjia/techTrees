#!/usr/local/bin/perl

use strict;
use warnings;
 
use Test::More;
use Capture::Tiny qw(capture);
use File::Temp qw(tempdir);
 
plan tests => 3;
 
subtest withOrderData => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=Jack&action=orderQuery';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr/ID.*userName.*Date.*Item.*/, 'order data';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};
 
subtest withoutOrderData => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=DDDD&action=orderQuery';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"error":"null order!"}}, 'null order data';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

subtest wrongUser  => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=&action=orderQuery';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"error":"null order!"}}, 'wrong user with null order data';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

