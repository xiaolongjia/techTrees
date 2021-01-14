#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
An integer N is given, representing the area of some rectangle.

The area of a rectangle whose sides are of length A and B is A * B, and the perimeter is 2 * (A + B).

The goal is to find the minimal perimeter of any rectangle whose area equals N. The sides of this rectangle should be only integers.

For example, given integer N = 30, rectangles of area 30 are:

(1, 30), with a perimeter of 62,
(2, 15), with a perimeter of 34,
(3, 10), with a perimeter of 26,
(5, 6), with a perimeter of 22.
Write a function:

sub solution { my ($N)=@_; ... }

that, given an integer N, returns the minimal perimeter of any rectangle whose area is exactly equal to N.

For example, given an integer N = 30, the function should return 22, as explained above.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..1,000,000,000].
=cut

my $N = 32;

print(&solution($N));

sub solution {
	my $data = shift;
	my $minPerimeter = $data*4;
	for (my $i=1; $i<=sqrt($data); $i++) {
		if ($data%$i == 0) {
			my $j = $data/$i;
			print($i," ", $j,"\n");
			my $currPerimeter = 2*($j+$i);
			if ($currPerimeter < $minPerimeter) {
				$minPerimeter = $currPerimeter;
			}
		}
	}
	return $minPerimeter;
}
