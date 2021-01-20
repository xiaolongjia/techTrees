#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Product Sum 

Write a function that takes in a "special" array and returns its product sum.

A "special" array is a non-empty array that contains either integers or other "special" arrays.

The product sum of a "special" array is the sum of its elements, where "special" arrays inside 
it are summed themselves and then multiplied by their level of depth.

The depth of a "special" array is how far nested it is. For instance, the depth of []
is 1: the depth of the inner array in [[]] is 2; the depth of the innermost array
in [[[]]] is 3. 

Therefore, the product sum of [x,y] is x + y; the product sum of [x, [y, z]]
is x + 2 * (y + z); the product sum of [x, [y, [z]]] is x + 2* (y + 3*z)

Sample Input:
array = [5, 2, [7, -1], 3, [6, [-13, 8], 4]]

Sample Output:
12 = 5+2+2*(7-1)+3+2*(6+3*(-13+8)+4)
=cut

my @childArray1 = (7, -1);
my @childArray2 = (-13, 8);
my @childArray3 = (6, \@childArray2, 4);
my @array = (5, 2, \@childArray1, 3, \@childArray3 );

print(Dumper(&productSum(\@array)));

sub productSum {
	my ($array) = @_;
	my $depth = 1;
	my $sum = 0;
	&getArraySum($array, $depth, \$sum);
	return $sum;
}

sub getArraySum {
	my ($currArray, $currDepth, $sum) = @_;
	for(@$currArray) {
		my $currElement = $_;
		if (ref($currElement) eq 'ARRAY') {
			&getArraySum($currElement, ($currDepth+1)*$currDepth, $sum);
		} else {
			$$sum += $currElement*$currDepth;
		}
	}
}

