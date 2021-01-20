#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Nth Fibonacci 

The Fibonacci sequence is defined as follows: the first number of the sequence is 0.
the second number is 1. and the nth number is the sum of the (n-1)th and (n-2)th numbers.

Write a function that takes in an integer n and returns the nth Fibonacci number.

Important note:
the Fibonacci sequence is often defined with its first two numbers as F0=0
and F1=1. For the purpose of this question, the first Fibonacci number is F0;
therefore, getNthFib(1) is equal to F0, getNthFib(2) is equal to F1, etc. 
=cut

print(Dumper(&getNthFib(9)));

sub getNthFib {
	my ($n) = @_;
	my ($i, $j) = (0, 1);
	if ($n == 1) {
		return $i;
	} elsif ($n == 2) {
		return $j;
	} else {
		for (my $k= 3; $k<= $n; $k++) {
			($i, $j) = ($j, $i+$j);
		}
		return $j;
	}
}

