#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
River Sizes 

You are given a two-dimensional array (a matrix) of potentially unequal height and 
width containing only 0 and 1. Each 0 represents land and each 1 represents part of a river.
A river consists of any number of 1 that are either horizontally or vertically 
adjacent (but not diagonally adjacent). The number of adjacent 1 forming a river 
determine its size. 

Note that a river can twist. In other words, it doesnot have to be a straight 
vertical line or a straight horizontal line; it can be L-shaped, for example.

Write a function that returns an array of the sizes of all rivers represented in 
the input matrix. The sizes do not need to be in any particular order. 

Sample Input:
matrix = [
    [1, 0, 0, 1, 0],
    [1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1],
    [1, 0, 1, 1, 0],
]

Sample Output: 
[1, 2, 2, 2, 5]
=cut

my @array = ([1, 0, 0, 1, 0],
			 [1, 1, 1, 0, 0],
			 [1, 0, 1, 0, 1],
			 [1, 0, 1, 0, 1],
			 [1, 0, 1, 1, 0]);
print(Dumper(&riverSizes(\@array)));

sub riverSizes {
	my ($array) = @_;
	my $length = scalar @$array;
	my $width = scalar @{$array[0]};
	my @landFlag =  map([(0) x $width], (1..$length));
	my @rivers = ();
	for (my $i=0; $i<$length; $i++) {
		for (my $j=0; $j<$width; $j++) {
			if ($array[$i][$j] ==0 or $landFlag[$i][$j] ==1) {
				next;
			}
			my $currRiver = 0;
			my @queue = ([$i, $j]);
			$landFlag[$i][$j] = 1;
			while (@queue) {
				my $currNode = shift @queue;
				my $currX = $currNode->[0];
				my $currY = $currNode->[1];
				#print("X: $currX \t Y: $currY \n");
				$currRiver += 1;
				if (($currX > 0) and $landFlag[$currX-1][$currY] ==0 and $array[$currX-1][$currY] ==1) {
					push @queue, [$currX-1, $currY];
					$landFlag[$currX-1][$currY] = 1;
				}
				if (($currX < $length - 1) and $landFlag[$currX+1][$currY] ==0 and $array[$currX+1][$currY] ==1) {
					push @queue, [$currX+1, $currY];
					$landFlag[$currX+1][$currY] = 1;
				}
				if (($currY > 0) and $landFlag[$currX][$currY-1] ==0 and $array[$currX][$currY-1] ==1) {
					push @queue, [$currX, $currY-1];
					$landFlag[$currX][$currY-1] = 1;
				}
				if (($currY < $width - 1) and $landFlag[$currX][$currY+1] ==0 and $array[$currX][$currY+1] ==1) {
					push @queue, [$currX, $currY+1];
					$landFlag[$currX][$currY+1] = 1;
				}
			}
			push @rivers, $currRiver;
		}
	}
	return \@rivers;
}


