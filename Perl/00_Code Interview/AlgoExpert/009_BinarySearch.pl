#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Binary Search 

Write a function that takes in a sorted array of integers as well as a target integer. The function should 

use the Binary Search algorithm to determine if the target integer is contained in the array and should return 

its index if it is, otherwise -1. 

Sample Input:
array = [0, 1, 21, 33, 45, 45, 61, 71, 72, 73]
target = 33

Sample Output:
3
=cut

my @array = (0, 1, 21, 33, 45, 45, 61, 71, 72, 73);
$target = 43;

print(Dumper(&binarySearch(\@array, $target)));

sub binarySearch {
	my ($array, $target) = @_;
	my @tArray = @$array;
	my $left = 0;
	my $right = $#tArray;
	while ($left <= $right) {
		print("left is $left right is $right\n");
		my $middle = int(($left+$right)/2);
		my $mvalue = $tArray[$middle];
		if ($mvalue > $target) {
			$right = $middle-1;
		} elsif ($mvalue < $target) {
			$left = $middle+1;
		} else {
			return $middle;
		}
	}
	return -1;
}
