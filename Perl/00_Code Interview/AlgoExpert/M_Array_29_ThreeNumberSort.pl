#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Three Number Sort 

You are given an array of integers and another array of three distinct integers. 
The first array is guaranteed to only contain integers that are in the second array, and the 
second array represents a desired order for the integers in the first array. 
For example, a second array of [x, y, z] represents a desired order of 
[x, x, ..., x, y, y, ..., y, z, z, ..., z] in the first array. 

Write a function that sorts the first array according to the desired order in the second array

The function should perform this in place (i.e., it should mutate the input array), and it 
should not use any auxiliary space(i.e., it should run with constant space: o(1)
space). 

Note that the desired order won't necessarily be ascending or descending and that 
the first array won't necessarily contain all three integers found in the second array
-- it might only contain one or two.

Sample Input:
array = [1,0,0,-1,-1,0,1,1]
order = [0,1,-1]

Sample Output:
[0, 0, 0, 1, 1, 1, -1, -1]
=cut

my @array = (1,0,0,-1,-1,0,1,1);
my @order = (0,1,-1);
print(Dumper(&threeNumberSort(\@array, \@order)));

sub threeNumberSort {
	my ($array, $order) = @_;
	my $dataRef = {};
	for (@$array) {
		my $data = $_;
		if (exists $dataRef->{$data}) {
			$dataRef->{$data} += 1;
		} else {
			$dataRef->{$data} = 1;
		}
	}
	my $index=0;
	for (@order) {
		my $data = $_;
		my $counter = 0;
		if (exists $dataRef->{$data}) {
			$counter = $dataRef->{$data};
		}
		for (my $i=0; $i<$counter; $i++) {
			$array[$index] = $data;
			$index += 1;
		}
	}
	return $array;
}



