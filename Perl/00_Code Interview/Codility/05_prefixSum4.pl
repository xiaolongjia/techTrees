#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A non-empty array A consisting of N integers is given. The consecutive elements of array A represent consecutive cars on a road.

Array A contains only 0s and/or 1s:

0 represents a car traveling east,
1 represents a car traveling west.
The goal is to count passing cars. We say that a pair of cars (P, Q), where 0 ¡Ü P < Q < N, is passing when P is traveling to the east and Q is traveling to the west.

For example, consider array A such that:

  A[0] = 0
  A[1] = 1
  A[2] = 0
  A[3] = 1
  A[4] = 1
We have five pairs of passing cars: (0, 1), (0, 3), (0, 4), (2, 3), (2, 4).

Write a function:

sub solution { my (@A)=@_; ... }

that, given a non-empty array A of N integers, returns the number of pairs of passing cars.

The function should return ?1 if the number of pairs of passing cars exceeds 1,000,000,000.

For example, given:

  A[0] = 0
  A[1] = 1
  A[2] = 0
  A[3] = 1
  A[4] = 1
the function should return 5, as explained above.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..100,000];
each element of array A is an integer that can have one of the following values: 0, 1.
=cut

my @A = (0, 1, 0, 1, 1);
print(&solution(\@A));

sub solution {
	my $A = shift;
	my @A = @$A;
	print(Dumper(\@A));
	my $currEast = 0;
	my $maxPairs = 0;
	for (my $i=0; $i<@A; $i++) {
		if ($A[$i] == 0) {
			$currEast += 1;
		}
		else {
			$maxPairs += $currEast;
		}
	}
	return $maxPairs;
}
