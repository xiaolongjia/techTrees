#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Monotonic Array

Write a function that takes in an array of integers and returns a boolean representing whether the array is monotonic.

An array is said to be monotonic if its elements, from left to right, are entirely non-increasing or 
entirely non-decreasing. 

Non-increasing elements aren't necessarily exclusively decreasing; they simply don't increase.
Similarly, non-decreasing elements aren't necessarily exclusively increasing; 
they simply don't decrease. 

Note that empty arrays and arrays of one element are monotonic. 

Sample Input:
array = [-1, -5, -10, -1100, -1100, -1101, -1102, -9001]

Sample Output:
True 
=cut

my @array = (-1, -5, -10, -1100, -1100, -1101, -1102, -9001);
print(Dumper(&isMonotonic(\@array)));

sub isMonotonic {
	my ($array) = @_;
	my @data =  @$array;
	if (@data <=1) {
		return 1;
	}
	
	my $lastTrend = 0; # 0: same; 1: increasing; 2: decreasing
	for (my $i=1; $i<@data; $i++) {
		if ($data[$i] > $data[$i-1]) {
			if ($lastTrend == 0) {
				$lastTrend = 1;
			} elsif ($lastTrend == 2) {
				return -1;
			}
		} elsif ($data[$i] < $data[$i-1]) {
			if ($lastTrend == 0) {
				$lastTrend = 2;
			} elsif ($lastTrend == 1) {
				return -1;
			}
		}
	}
	return 1;
}
