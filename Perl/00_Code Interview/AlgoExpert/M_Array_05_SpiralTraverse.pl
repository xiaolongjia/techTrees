#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Spiral Traverse

Write a function that takes in an n x m two-dimensional array (that can be 
square-shaped when n == m) and returns a one-dimensional array of all the 
array's elements in spiral order. 

Spiral order starts at the top left corner of the two-dimensional array, goes to 
the right, and proceeds in a spiral pattern all the way until every element has been visited. 

Sample Input:
array = [
    [ 1,  2,  3, 4],
    [12, 13, 14, 5],
    [11, 16, 15, 6],
    [10,  9,  8, 7]
]

Sample Output:
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] 
=cut
my @arrayOne = (1,  2,  3, 4);
my @arrayTwo = (12, 13, 14, 5);
my @arrayThree = (11, 16, 15, 6);
my @arrayFour = (10,  9,  8, 7);

my @array = (\@arrayOne, \@arrayTwo, \@arrayThree, \@arrayFour);
print(Dumper(&isMonotonic(\@array)));

sub isMonotonic {
	my ($array) = @_;
	my @data =  @$array;
	my @result = ();
	
	my ($start_x, $end_x) = (0, @{$data[0]} - 1);
	my ($start_y, $end_y) = (0, @data-1);
	while ($start_x < $end_x and $start_y< $end_y) {
		for (my $i = $start_x; $i <= $end_x; $i++) {
			push @result, $data[$start_y][$i];
		}
		for (my $i = $start_y+1; $i <= $end_y; $i++) {
			push @result, $data[$i][$end_x];
		}
		for (my $i = $end_x-1; $i>=$start_x; $i--) {
			if ($start_y == $end_y) {
				last;
			}
			push @result, $data[$end_y][$i];
		}
		for (my $i = $end_y-1; $i>= $start_y+1; $i--) {
			if ($start_x == $end_x) {
				last;
			}
			push @result, $data[$i][$start_x];
		}
		$start_y += 1;
		$end_x -= 1;
		$end_y -= 1;
		$start_x += 1;
	}
	return \@result;
}
