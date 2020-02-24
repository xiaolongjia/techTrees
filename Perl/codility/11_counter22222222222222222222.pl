#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A prime is a positive integer X that has exactly two distinct divisors: 1 and X. The first few prime integers are 2, 3, 5, 7, 11 and 13.

A semiprime is a natural number that is the product of two (not necessarily distinct) prime numbers. The first few semiprimes are 4, 6, 9, 10, 14, 15, 21, 22, 25, 26.

You are given two non-empty arrays P and Q, each consisting of M integers. These arrays represent queries about the number of semiprimes within specified ranges.

Query K requires you to find the number of semiprimes within the range (P[K], Q[K]), where 1 ¡Ü P[K] ¡Ü Q[K] ¡Ü N.

For example, consider an integer N = 26 and arrays P, Q such that:

    P[0] = 1    Q[0] = 26
    P[1] = 4    Q[1] = 10
    P[2] = 16   Q[2] = 20
The number of semiprimes within each of these ranges is as follows:

(1, 26) is 10,
(4, 10) is 4,
(16, 20) is 0.
Write a function:

sub solution { my ($N, $P, $Q)=@_; my @P=@$P; my @Q=@$Q; ... }

that, given an integer N and two non-empty arrays P and Q consisting of M integers, returns an array consisting of M elements specifying the consecutive answers to all the queries.

For example, given an integer N = 26 and arrays P, Q such that:

    P[0] = 1    Q[0] = 26
    P[1] = 4    Q[1] = 10
    P[2] = 16   Q[2] = 20
the function should return the values [10, 4, 0], as explained above.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..50,000];
M is an integer within the range [1..30,000];
each element of arrays P, Q is an integer within the range [1..N];
P[i] ¡Ü Q[i].
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
