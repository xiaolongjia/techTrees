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

my @P = (1, 4, 16);
my @Q = (26, 10, 20);
my $N = 26;

print(&solution(\@P, \@Q, $N));

sub solution {
	my ($P, $Q, $N) = @_;
	my @P = @$P;
	my @Q = @$Q;
	
	my @primes;
	my @semiprimes;
	for (my $i=2; $i<=$N; $i++) {
		my $isPrime = 1;
		for (my $j=$i-1; $j>1; $j--) {
			if ($i%$j ==0) {
				$isPrime = 0;
			}
		}
		if ($isPrime == 1) {
			push @primes, $i;
		}
	}
	for (my $i=0; $i<@primes; $i++){
		for (my $j=$i; $j<@primes; $j++){
			my $number = $primes[$i]*$primes[$j];
			if ($number <= $N) {
				push @semiprimes, $number;
			}
		}
	}
	my @final;
	for (my $i=0; $i<@P; $i++) {
		my @result;
		for (@semiprimes) {
			my $currnumber = $_;
			if (($currnumber>= $P[$i]) and ($currnumber<=$Q[$i])) {
				push @result, $currnumber;
			}
		}
		push @final, scalar @result;
	}
	print(Dumper(\@final));
}
