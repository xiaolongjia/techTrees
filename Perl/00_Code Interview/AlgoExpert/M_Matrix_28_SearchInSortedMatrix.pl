#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Search in Sorted Matrix  

You are given a two-dimensional array (a matrix) of distinct integers and a target integer 
Each row in the matrix is sorted, and each column is alse sorted; the matrix doesnot 
necessarily have the same height and width. 

Write a function that returns an array of the row and column indices of the target integer 
if its contained in the matrix, otherwise [-1, -1]

Sample Input:
matrix  = [
[1, 4, 7, 12, 15, 1000],
[2, 5, 19, 31, 32, 1001],
[3, 8, 24, 33, 35, 1002],
[40, 41, 42, 44, 45, 1003],
[99, 100, 103, 106, 128, 1004],
]
target = 44

Sample Output:
[[3, 3]]
=cut

my @matrix = (
[1, 4, 7, 12, 15, 1000],
[2, 5, 19, 31, 32, 1001],
[3, 8, 24, 33, 35, 1002],
[40, 41, 42, 44, 45, 1003],
[99, 100, 103, 106, 128, 1004],
);

print(Dumper(&searchInSortedMatrix(\@matrix, 47)));

sub searchInSortedMatrix {
	my ($matrix, $target) = @_;
	my @result = ();	
	my $width  = scalar @{$matrix[0]} - 1;
	my $length = scalar @$matrix - 1;
	my $x = 0;
	my $y = $width;
	while ($x <= $length and $y >=0) {
		my $topright = $matrix[$x][$y];
		if ($topright == $target) {
			@result = ($x, $y);
			last;
		} elsif ($topright > $target) {
			$y -= 1;
		} else {
			$x += 1;
		}
	}
	return \@result;
}

