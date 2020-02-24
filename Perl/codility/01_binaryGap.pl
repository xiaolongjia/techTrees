#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A binary gap within a positive integer N is any maximal sequence of consecutive zeros that is surrounded by ones at both ends in the binary representation of N.

For example, number 9 has binary representation 1001 and contains a binary gap of length 2. The number 529 has binary representation 1000010001 and contains two binary gaps: one of length 4 and one of length 3. The number 20 has binary representation 10100 and contains one binary gap of length 1. The number 15 has binary representation 1111 and has no binary gaps. The number 32 has binary representation 100000 and has no binary gaps.

Write a function:

sub solution { my ($N)=@_; ... }

that, given a positive integer N, returns the length of its longest binary gap. The function should return 0 if N doesn't contain a binary gap.

For example, given N = 1041 the function should return 5, because N has binary representation 10000010001 and so its longest binary gap is of length 5. Given N = 32 the function should return 0, because N has binary representation '100000' and thus no binary gaps.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..2,147,483,647].
Copyright 2009¨C2020 by Codility Limited. All Rights Reserved. Unauthorized copying, publication or disclosure prohibited.
=cut

&solution(1041);

sub solution {
	my ($N) = shift; 
	my $Str = sprintf("%b", $N)+0;
	my @numbers = split("", $Str);
	print(Dumper(@numbers));
	my $currGap = 0;

	for ($i=0; $i<@numbers-1; $i++) {
		if ($numbers[$i] == 0) {
			next;
		}
		else {
			for ($j=$i+1; $j<@numbers; $j++) {
				if ($numbers[$j] == 1) {
					my $GapNow = $j - $i - 1; 
					if ($GapNow > 0 and $GapNow > $currGap) {
						$currGap = $GapNow;
					}
					$i = $j - 1;
				}
			}
		}
	}
	print("max gap is: ", $currGap);
}
