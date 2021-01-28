#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Single Cycle Check 

You are given an array of integers where each integer represents a jump of its value 
in the array. For instance, the integer 2 represents a jump of two indices forward 
in the array; the integer -3 represents a jump of three indices backward in the array. 

If a jump spills past the array's bounds, it wraps over to the other side. for instance, a jump 
of -1 at index 0 brings us to the last index in the array. Similarly, a jump of 1
at the last index in the array brings us to index 0.

Write a function that returns a boolean representing whether the jumps in the array form 
a sing cycle. A single cycle occurs if, starting at any index in the array and following the jumps, 
every element in the array is visited exactly once before landing back on the starting index.

Sample Input:
array = [2, 3, 1, -4, -4, 2]
  
Sample Output: 
true 
=cut

my @array = (10, 11, -6, -23, -2, 3, 88, 909, -26);
print(Dumper(&hasSingleCycle(\@array)));

sub hasSingleCycle {
	my ($array) = @_;
	my @data = @$array;
	my %visited;
	my $length = scalar @data;
	my $currIdx = 0;
	for (my $i=0; $i<@data; $i++) {
		my $currSteps = $data[$currIdx];
		if(!(exists $visited{$currIdx})) {
			$visited{$currIdx} = 1;
		}
		$currIdx = $currIdx + $currSteps;
		if ($currIdx <0) {
			my $left = abs($currIdx)%$length;
			$currIdx = $length - $left;
		} else {
			$currIdx %= $length;
		}
	}
	return (($length == scalar keys %visited) and ($currIdx ==0));
}


