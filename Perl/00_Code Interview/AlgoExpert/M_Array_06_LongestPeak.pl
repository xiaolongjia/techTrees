#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Longest Peak

Write a function that takes in an array of integers and returns the length of the 
longest peak in the array. 

A peak is defined as adjacent integers in the array that are strictly increasing 
until they reach a tip (the highest value in the peak), at which point they 
become strictly decreasing. At least three integers are required to form a peak.

For example, the integers 1, 4, 10, 2 form a peak, but the integers 4, 0, 10
don't and neither do the integers 1, 2, 2, 0.
Similarly, the integers 1, 2, 3 don't form a peak because there aren't any strictly
decreasing integers after the 3.

Sample Input:
array = [ 1,  2,  3, 3, 4, 0, 10, 6, 5, -1, -3, 2, 3]

Sample Output:
6
=cut

my @array = (1, 2, 3, 3, 8, 0, 1, 10, 6, -1, 2, 3);
print(Dumper(&longestPeak(\@array)));

sub longestPeak {
	my ($array) = @_;
	my @data =  @$array;
	my $maxLength = 0;
	for (my $i=1; $i< $#data; $i++) {
		if ($data[$i] > $data[$i-1] and $data[$i] > $data[$i+1]) {
			print($i,"\n");
			my $left = $i;
			my $right = $i;
			while ($data[$left] >= $data[$left-1] and $left > 0) {
				$left -= 1;
			}
			while ($data[$right] >= $data[$right+1] and $right < $#data) {
				$right += 1;
			}
			my $currLength = $right - $left + 1;
			if ($currLength > $maxLength) {
				print("$right - $left\n");
				$maxLength = $currLength;
			}
		}
	}
	return $maxLength;
}
