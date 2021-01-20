#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Given two non-empty arrays of integers, write a function that determines whether the second array is a subsequence of the first one. 

A subsequence of an array is a set of numbers that aren't necessarily adjacent in the array but that are in the same order as they appear in the array. 
For instance, the numbers [1,3,4] from a subsequence of the array [1,2,3,4], and so do the numbers [2, 4]. 

Note that a single number in an array and the array itself are both valid subsequences of the array. 

Sample input:
array = [5, 1, 22, 25, 6, -1, 8, 10]
sequence = [1,6, -1, 10]

Sample output:
true
=cut

my @array = (5, 1, 22, 25, 6, -1, 8, 10);
my @sequence = (1,6, -1, 10);
print(Dumper(&isValidSubsequence(\@array, \@sequence)));


sub isValidSubsequence {
	my $array = shift;
	my $sequence   = shift;
	my @tArray = @$array;
	my @tSequence = @$sequence;
	
	my $seqIdx = 0;
	my $arrIdx = 0;
	while ($seqIdx <= $#tSequence and $arrIdx <= $#tArray) {
		if ($tArray[$arrIdx] == $tSequence[$seqIdx]) {
			$seqIdx += 1;
			$arrIdx += 1;
		} else {
			$arrIdx += 1;
		}
	}
	return $seqIdx == scalar @tSequence;
}

