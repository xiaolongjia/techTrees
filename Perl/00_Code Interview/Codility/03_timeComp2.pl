#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
An array A consisting of N different integers is given. The array contains integers in the range [1..(N + 1)], which means that exactly one element is missing.

Your goal is to find that missing element.

Write a function:

sub solution { my (@A)=@_; ... }

that, given an array A, returns the value of the missing element.

For example, given array A such that:

  A[0] = 2
  A[1] = 3
  A[2] = 1
  A[3] = 5
the function should return 4, as it is the missing element.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [0..100,000];
the elements of A are all distinct;
each element of array A is an integer within the range [1..(N + 1)].
=cut

@A = (2,3,1,5,7,4);
print(&solution(\@A));

sub solution {
	my $data = shift;
	my @data = @$data;
	my $length = scalar @data + 1;
	my $sum = ($length*($length+1))/2;
	for(@data) {
		$sum -= $_;
	}
	return $sum;
}
