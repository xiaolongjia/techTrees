#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Selection Sort  

Write a function that takes in an array of integers and returns a sorted version of that array.

Use the Selection Sort algorithm to sort the array. 

Sample Input:
array = [8, 5, 2, 9, 5, 6, 3]

Sample Output:
[2, 3, 5, 5, 6, 8, 9]
=cut

my @array = (141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7);
print(Dumper(&selectionSort(\@array)));

sub selectionSort {
	my ($array) = @_;
	my @tArray = @$array;
	for (my $i=0; $i <= $#tArray; $i++) {
		my $min_idx = $i;
		for (my $j=$i+1; $j<= $#tArray; $j++) {
			if ($tArray[$min_idx] > $tArray[$j]) {
				$min_idx = $j;
			}
		}
		($tArray[$i], $tArray[$min_idx]) = ($tArray[$min_idx], $tArray[$i]) ;
	}
	return \@tArray;
}
