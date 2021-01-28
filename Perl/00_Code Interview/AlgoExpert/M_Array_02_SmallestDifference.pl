#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Smallest Difference

Write a function that takes in two non-empty array of integers, finds the pair of 
numbers (one from each array) whose absolute difference is closest to Zero, 
and returns an array containing these two numbers, with the number from the first array 
in the first position. 

Note that the absolute difference of two integers is the distance between them 
on the real number line. For example, the absolute difference of -5 and 5 is 10, and 
the absolute difference of -5 and -4 is 1. 

(remove) You can assume that there will only be one pair of numbers with the smallest difference.

Sample Input:
arrayOne = [-1, 5, 10, 20, 28,3]
arrayTwo = [26, 134, 135, 15, 17]

Sample Output:
[28, 26]
=cut

my @arrayOne = (-1, 5, 10, 20, 28,3);
my @arrayTwo = (26, 134, 135, 15, 17);

print(Dumper(&smallestDifference(\@arrayOne, \@arrayTwo)));

sub smallestDifference {
	my ($arrayOne, $arrayTwo) = @_;
	my @dataOne = sort {$a <=> $b} @$arrayOne;
	my @dataTwo = sort {$a <=> $b} @$arrayTwo;
	
	my $minDiff = 2**53;
	my @result = ();
	
	my $oneIdx = 0;
	my $twoIdx = 0;
	while ($oneIdx < @dataOne and $twoIdx < @dataTwo) {
		my $currDiff = abs($dataOne[$oneIdx] - $dataTwo[$twoIdx]);
		if ($currDiff < $minDiff) {
			$minDiff = $currDiff;
			@result = ($dataOne[$oneIdx], $dataTwo[$twoIdx]);
		}
		if ($dataOne[$oneIdx] > $dataTwo[$twoIdx]) {
			$twoIdx += 1;
		} elsif ($dataOne[$oneIdx] < $dataTwo[$twoIdx]) {
			$oneIdx += 1;
		} else {
			@result = ($dataOne[$oneIdx], $dataTwo[$twoIdx]);
			return (\@result);
		}
	}
	return (\@result);
}

