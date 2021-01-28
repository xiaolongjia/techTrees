#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Move Element To End

You're given an array of integers and an integer. Write a function that moves all 
instances of that integer in the array to the end of the array and returns the array.

The function should perform this in place(i.e., it should mutate the input array) and 
doesn't need to maintain the order of the other integers. 

Sample Input:
array = [2, 1, 2, 2, 2, 3, 4, 2]
toMove = 2

Sample Output:
[1, 3, 4, 2, 2, 2, 2, 2]
=cut

my @array = (2, 1, 2, 2, 2, 3, 4, 2);
my $toMove = 2;

print(Dumper(&moveElementToEnd(\@array, $toMove)));
print(Dumper(&moveElementToBegin(\@array, $toMove)));

sub moveElementToEnd {
	my ($array, $toMove) = @_;
	my @data = @$array;
	my $left = 0;
	my $right = $#data;
	while ($left < $right) {
		while ($right >=0 and $data[$right] == $toMove) {
			$right -= 1;
		}
		if ($left < $right) {
			if ($data[$left] == $toMove) {
				($data[$left], $data[$right]) = ($data[$right], $data[$left]);
			}
		}
		$left += 1;
	}
	return \@data;
}

sub moveElementToBegin {
	my ($array, $toMove) = @_;
	my @data = @$array;
	my $left = 0;
	my $right = $#data;
	while ($left < $right) {
		while ($left <= $#data and $data[$left] == $toMove) {
			$left += 1;
		}
		if ($left < $right) {
			if ($data[$right] == $toMove) {
				($data[$right], $data[$left]) = ($data[$left], $data[$right]);
			}
		}
		$right -= 1;
	}
	return \@data;
}

