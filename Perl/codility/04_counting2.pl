#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
You are given N counters, initially set to 0, and you have two possible operations on them:

increase(X) ? counter X is increased by 1,
max counter ? all counters are set to the maximum value of any counter.
A non-empty array A of M integers is given. This array represents consecutive operations:

if A[K] = X, such that 1 ¡Ü X ¡Ü N, then operation K is increase(X),
if A[K] = N + 1 then operation K is max counter.
For example, given integer N = 5 and array A such that:

    A[0] = 3
    A[1] = 4
    A[2] = 4
    A[3] = 6
    A[4] = 1
    A[5] = 4
    A[6] = 4
the values of the counters after each consecutive operation will be:

    (0, 0, 1, 0, 0)
    (0, 0, 1, 1, 0)
    (0, 0, 1, 2, 0)
    (2, 2, 2, 2, 2)
    (3, 2, 2, 2, 2)
    (3, 2, 2, 3, 2)
    (3, 2, 2, 4, 2)
The goal is to calculate the value of every counter after all operations.

Write a function:

sub solution { my ($N, @A)=@_; ... }

that, given an integer N and a non-empty array A consisting of M integers, returns a sequence of integers representing the values of the counters.

Result array should be returned as an array of integers.

For example, given:

    A[0] = 3
    A[1] = 4
    A[2] = 4
    A[3] = 6
    A[4] = 1
    A[5] = 4
    A[6] = 4
the function should return [3, 2, 2, 4, 2], as explained above.

Write an efficient algorithm for the following assumptions:

N and M are integers within the range [1..100,000];
each element of array A is an integer within the range [1..N + 1].
=cut

my @A = (3, 4, 4, 6, 1, 4, 4, 6, 2);
my $k = 5;
print(&solution($k, \@A));

sub solution {
	my $k = shift;
	my $data = shift;
	my @data = @$data;

	my @counter = (0) x $k;
	my $maxCounter = 0;

	for (my $i=0; $i<@data; $i++) {
		if ($data[$i] >= 1 and $data[$i]<= $k) {
			$counter[$data[$i]-1] += 1;
			if ($counter[$data[$i]-1] > $maxCounter) {
				$maxCounter = $counter[$data[$i]-1];
			}
		}
		if ($data[$i] == $k+1) {
			@counter = ();
			@counter = ($maxCounter) x $k;
			#@counter = split//, $maxCounter x $k;
		}
		print(Dumper(\@counter));
	}
}

