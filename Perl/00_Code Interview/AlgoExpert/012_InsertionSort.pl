#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Insertion Sort  

Write a function that takes in an array of integers and returns a sorted version of that array.

Use the Insertion Sort algorithm to sort the array. 

Sample Input:
array = [8, 5, 2, 9, 5, 6, 3]

Sample Output:
[2, 3, 5, 5, 6, 8, 9]
=cut

my @array = (141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7);
print(Dumper(&insertionSort(\@array)));

sub insertionSort {
	my ($array) = @_;
	my @tArray = @$array;
	for (my $i=1; $i <= $#tArray; $i++) {
		my $j = $i;
		while ($j>0 and $tArray[$j] < $tArray[$j-1]) {
			($tArray[$j-1], $tArray[$j]) = ($tArray[$j], $tArray[$j-1]) ;
			$j -= 1;
		}
	}
	return \@tArray;
}
