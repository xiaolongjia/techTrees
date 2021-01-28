#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
kadane's Algorithm

Write a function that takes in a non-empty array of integers and returns the 
maximum sum that can be obtained by summing up all of the integers in a 
non-empty subarray of the input array. A subarray must only contain adjacent 
numbers (numbers next to each other in the input array).

Sample Input:
array = [3, 5, -9, 1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4]
  
Sample Output: 
19 // [1, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1]
=cut

my @array = (3, 5, -9, 1, 7, -3, 8, 3, -2, 3, 4, 7, 2, -9, 6, 3, 1, -5, 4);
print(Dumper(&kadanesAlgorithm(\@array)));

sub kadanesAlgorithm {
	my ($array) = @_;
	my @data = @$array;
	
	my $maximum = $data[0];
	my $currMax = $data[0];
	
	for (my $i=1; $i<@data; $i++) {
		$currMax = (($currMax+$array[$i]) > $array[$i]) ? $currMax+$array[$i] : $array[$i];
		$maximum = ($maximum < $currMax) ? $currMax : $maximum;
	}	
	return $maximum;
}

