#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
An array A consisting of N integers is given. A triplet (P, Q, R) is triangular if 0 ¡Ü P < Q < R < N and:

A[P] + A[Q] > A[R],
A[Q] + A[R] > A[P],
A[R] + A[P] > A[Q].
For example, consider array A such that:

  A[0] = 10    A[1] = 2    A[2] = 5
  A[3] = 1     A[4] = 8    A[5] = 20
Triplet (0, 2, 4) is triangular.

Write a function:

sub solution { my (@A)=@_; ... }

that, given an array A consisting of N integers, returns 1 if there exists a triangular triplet for this array and returns 0 otherwise.

For example, given array A such that:

  A[0] = 10    A[1] = 2    A[2] = 5
  A[3] = 1     A[4] = 8    A[5] = 20
the function should return 1, as explained above. Given array A such that:

  A[0] = 10    A[1] = 50    A[2] = 5
  A[3] = 1
the function should return 0.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [0..100,000];
each element of array A is an integer within the range [?2,147,483,648..2,147,483,647].
=cut

my @A = (10, 50, 1, 5);
#my @A = (10, 2, 5, 1, 8, 20);
print(&solution(\@A));

sub solution {
	my $A = shift;
	my @A = @$A;
	my @newData = sort {$a <=> $b} @A;
	my $lastIndex = $#newData;
	for (my $i = $lastIndex; $i>=2; $i--) {
		if ($newData[$i] < ($newData[$i-1] + $newData[$i-2])) {
			return 1;
		}
	}
	return 0;
}
