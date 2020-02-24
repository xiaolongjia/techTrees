#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A positive integer D is a factor of a positive integer N if there exists an integer M such that N = D * M.

For example, 6 is a factor of 24, because M = 4 satisfies the above condition (24 = 6 * 4).

Write a function:

sub solution { my ($N)=@_; ... }

that, given a positive integer N, returns the number of its factors.

For example, given N = 24, the function should return 8, because 24 has 8 factors, namely 1, 2, 3, 4, 6, 8, 12, 24. There are no other factors of 24.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..2,147,483,647].
=cut

my $N = 36;

print(&solution($N));

sub solution {
	my $data = shift;
	my $counter =1;
	for (my $i=2; $i<=sqrt($data); $i++) {
		if ($data%$i == 0) {
			if ($i*$i < $data) {
				$counter += 2;
			}
			else {
				$counter += 1;
			}
		}
	}
	return $counter;
}
