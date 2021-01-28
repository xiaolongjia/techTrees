#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Max Subset Sum No Adjacent

Write a function that takes in an array of positive integers and returns the 
maximum sum of non-adjacent elements in the array. If the input array is empty, returns 0

Sample Input:
array = [75, 105, 120, 75, 90, 135]  
Sample Output: 
330 // 75+ 120 + 135
=cut

my @array = (75, 105, 120, 75, 90, 135, 213, 98, 102);
print(Dumper(&maxSubsetSumNoAdjacent(\@array)));

sub maxSubsetSumNoAdjacent {
	my ($array) = @_;
	my @data = @$array;
	my @maximum = map($_, @data);
	$maximum[1] = ($data[0] > $data[1]) ? $data[0] : $data[1];	
	my $i=2;
	for (; $i<@data; $i++) {
		$maximum[$i] = (($maximum[$i-2]+$array[$i]) > $maximum[$i-1]) ? $maximum[$i-2]+$array[$i] : $maximum[$i-1];
	}	
	return $maximum[$i-1];
}
