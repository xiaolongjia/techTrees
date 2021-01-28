#!/usr/local/bin/perl

use strict;
use warnings;
 
use Test::More;
use Capture::Tiny qw(capture);
use File::Temp qw(tempdir);
 
plan tests => 3;
 
subtest normalSubmit => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=Jack&price=88&product=Test&action=submit';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr/.*success.*/, 'normal submit';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};
 
subtest submitNull => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'action=submit';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"Failed" : "Cancelled"}}, 'null data';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

subtest wrongArguments  => sub {
    plan tests => 3;
    local $ENV{REQUEST_METHOD} = 'GET';
    local $ENV{QUERY_STRING}   = 'username=Jack&item=Test&aaa=bbb&action=submit';
    my ($out, $err, $exit) = capture { system "../bin/process.fcgi" };
    like $out, qr{{"Failed" : "Cancelled"}}, 'wrong Arguments';
    is $err, '', 'stderr is empty';
    is $exit, 0, 'exit code is 0';
};

