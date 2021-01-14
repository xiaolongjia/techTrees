#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
You are given an array A consisting of N integers.

For each number A[i] such that 0 ¡Ü i < N, we want to count the number of elements of the array that are not the divisors of A[i]. We say that these elements are non-divisors.

For example, consider integer N = 5 and array A such that:

    A[0] = 3
    A[1] = 1
    A[2] = 2
    A[3] = 3
    A[4] = 6
For the following elements:

A[0] = 3, the non-divisors are: 2, 6,
A[1] = 1, the non-divisors are: 3, 2, 3, 6,
A[2] = 2, the non-divisors are: 3, 3, 6,
A[3] = 3, the non-divisors are: 2, 6,
A[4] = 6, there aren't any non-divisors.
Write a function:

sub solution { my (@A)=@_; ... }

that, given an array A consisting of N integers, returns a sequence of integers representing the amount of non-divisors.

Result array should be returned as an array of integers.

For example, given:

    A[0] = 3
    A[1] = 1
    A[2] = 2
    A[3] = 3
    A[4] = 6
the function should return [2, 4, 3, 2, 0], as explained above.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..50,000];
each element of array A is an integer within the range [1..2 * N].
=cut

my @A = (3, 8, 2, 3, 6, 4);

print(&solution(\@A));

sub solution {
	my $data = shift;
	my @data = @$data;
	my $nonDivisor = {};
	my @nonDivisors = ();

	for (my $i=0; $i<@data; $i++) {
		for (my $j=$i+1; $j<@data; $j++) {
			if ($data[$i]%$data[$j] == 0) {
				if (!($data[$j] == $data[$i])) {
					if (exists $nonDivisor->{$data[$j]}) {
						push @{$nonDivisor->{$data[$j]}}, $data[$i];
					}
					else {
						@{$nonDivisor->{$data[$j]}} = ($data[$i]);
					}
				}
			}
			else {
				if (exists $nonDivisor->{$data[$i]}) {
					push @{$nonDivisor->{$data[$i]}}, $data[$j];
				}
				else {
					@{$nonDivisor->{$data[$i]}} = ($data[$j]);
				}
				if ($data[$j] % $data[$i] != 0) {
					if (exists $nonDivisor->{$data[$j]}) {
						push @{$nonDivisor->{$data[$j]}}, $data[$i];
					}
					else {
						@{$nonDivisor->{$data[$j]}} = ($data[$i]);
					}
				}
			}
		}
		if (exists $nonDivisor->{$data[$i]}) {
			push @nonDivisors, scalar @{$nonDivisor->{$data[$i]}};
			delete $nonDivisor->{$data[$i]};
		}
		else {
			push @nonDivisors, 0;
		}
	}
	print(Dumper(@nonDivisors));sleep(2);
	return $counter;
}
