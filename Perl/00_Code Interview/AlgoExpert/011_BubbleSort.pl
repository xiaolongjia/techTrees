#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Bubble Sort  

Write a function that takes in an array of integers and returns a sorted version of that array.

Use the Bubble Sort algorithm to sort the array. 

Sample Input:
array = [8, 5, 2, 9, 5, 6, 3]

Sample Output:
[2, 3, 5, 5, 6, 8, 9]
=cut

my @array = (141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7);
print(Dumper(&bubbleSort(\@array)));

sub bubbleSort {
	my ($array) = @_;
	my @tArray = @$array;
	for (my $i=0; $i <= $#tArray; $i++) {
		for (my $j=0; $j < $#tArray-$i; $j++) {
			if ($tArray[$j] > $tArray[$j+1]) {
				($tArray[$j], $tArray[$j+1]) = ($tArray[$j+1], $tArray[$j]);
			}
		}
	}
	return \@tArray;
}
