#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Write a function that takes in a non-empty array of distinct integers and an integer 
representing a target sum. 

If any two numbers in the input array sum up to the target sum, the function should return them in an array, in any order. If no two numbers sum up to the target sum, the function should return an empty array.

Note that the target sum has to be obtained by summing two different integers in the array;
you cannot add a single integer to itself in order to obtain the target sum.

You can assume that there will be at most one pair of numbers summing up to the target sum.

Sample Input
array = [3, 5, -4, 8, 11, 1, -1, 6]
targetSum = 10

Sample Output: 
[-1, 11]
=cut

my @array = (3, 5, -4, 8, 11, 1, -1, 6);
my $target = 10;
print(Dumper(&twoNumberSum(\@array, $target)));


sub twoNumberSum {
	my $array = shift;
	my $tgt   = shift;
	my @tArray = sort {$a <=> $b} @$array;
	print(Dumper(\@tArray));
	my $i = 0;
	my $j = $#tArray;
	while ($i<$j) {
		my $sum = $tArray[$i] + $tArray[$j];
		if ($sum == $tgt) {
			my @result = @tArray[$i, $j];
			return \@result;
		} elsif ($sum > $tgt) {
			$j -= 1;
		} elsif ($sum < $tgt) {
			$i += 1;
		}
	}
	return ();
}


