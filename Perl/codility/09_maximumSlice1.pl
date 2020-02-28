#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A non-empty array A consisting of N integers is given.

A triplet (X, Y, Z), such that 0 ¡Ü X < Y < Z < N, is called a double slice.

The sum of double slice (X, Y, Z) is the total of A[X + 1] + A[X + 2] + ... + A[Y ? 1] + A[Y + 1] + A[Y + 2] + ... + A[Z ? 1].

For example, array A such that:

    A[0] = 3
    A[1] = 2
    A[2] = 6
    A[3] = -1
    A[4] = 4
    A[5] = 5
    A[6] = -1
    A[7] = 2
contains the following example double slices:

double slice (0, 3, 6), sum is 2 + 6 + 4 + 5 = 17,
double slice (0, 3, 7), sum is 2 + 6 + 4 + 5 ? 1 = 16,
double slice (3, 4, 5), sum is 0.
The goal is to find the maximal sum of any double slice.

Write a function:

sub solution { my (@A)=@_; ... }

that, given a non-empty array A consisting of N integers, returns the maximal sum of any double slice.

For example, given:

    A[0] = 3
    A[1] = 2
    A[2] = 6
    A[3] = -1
    A[4] = 4
    A[5] = 5
    A[6] = -1
    A[7] = 2
the function should return 17, because no double slice of array A has a sum of greater than 17.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [3..100,000];
each element of array A is an integer within the range [?10,000..10,000].
=cut

my @A = (3, 2, 6, -1, 4, -3, 3, 5, -1, 2, 2);

print(&solution(\@A));

sub solution {
	my $data = shift;
	my @data = @$data;

	my $maxsum = 0;
	for (my $i=1; $i<@data-1; $i++) {
		my $currLsum =0;
		my $currLmax =0;
		for (my $left=$i-1; $left>0; $left--) {
		       if ($left == $i-1) {
			       $currLsum=$data[$left];
			       $currLmax=$data[$left];
		       }       
		       else {
			       $currLsum+=$data[$left];
			       if ($currLsum > $currLmax) {
				       $currLmax = $currLsum;
			       }
		       }
	        }
		my $currRsum =0;
		my $currRmax =0;
		for (my $right=$i+1; $right<@data-1; $right++) {
		       if ($right == $i+1) {
			       $currRsum=$data[$right];
			       $currRmax=$data[$right];
		       }
		       else {
			       $currRsum+=$data[$right];
			       if ($currRsum > $currRmax) {
				       $currRmax = $currRsum;
			       }
		       }
	       }
	       if ($currLmax+$currRmax>$maxsum) {
		       $maxsum = $currLmax + $currRmax;
	       }
       }
       return $maxsum;
}
