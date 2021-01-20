#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;
use IO::Handle;

open (IN, "test.txt")||die "can't open file: test.txt\n";
my $tmpfile =$$."_tmp.txt";
open (OUT,">$tmpfile")||die "can't open tmpfile:$tmpfile\n";

while (<IN>) {
        my $lines = $_;
        $lines =~ s/name=\"cmd\"//;
        $lines =~ s/^\s+\<(\d+)/\t\<cmd name=\"$1\"/;
        print OUT $lines;
}
close (IN);
close (OUT);



