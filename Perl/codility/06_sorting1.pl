#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
Write a function

sub solution { my (@A)=@_; ... }

that, given an array A consisting of N integers, returns the number of distinct values in array A.

For example, given array A consisting of six elements such that:

 A[0] = 2    A[1] = 1    A[2] = 1
 A[3] = 2    A[4] = 3    A[5] = 1
the function should return 3, because there are 3 distinct values appearing in array A, namely 1, 2 and 3.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [0..100,000];
each element of array A is an integer within the range [?1,000,000..1,000,000].
=cut

my @A = (2, 1, 1, 2, 3, 1);
print(&solution(\@A));

sub solution {
	my $A = shift;
	my @A = @$A;
	my $myhash = {};
	print(Dumper(\@A));
	for (my $i=0; $i<@A; $i++) {
		if (exists $myhash->{$A[$i]}) {
			$myhash->{$A[$i]} += 1;
		}
		else {
			$myhash->{$A[$i]} = 1;
		}
	}
	my $counter = 0;
	foreach my $mykey (keys %$myhash) {
		if ($myhash->{$mykey} == 1) {
		       $counter += 1;
		}
	}
	return $counter;
}
