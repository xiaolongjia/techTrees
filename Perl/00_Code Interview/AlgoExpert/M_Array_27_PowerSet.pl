#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
PowerSet 

Write a function that takes in an array of unique integers and returns its powerset.

The powerset P(x) of a set x is the set of all subsets of x. For example, the powerset
of [1,2] is [[], [1], [2], [1,2]]. Note that the sets in the powerset do not need to be in any particular order.

Sample Input:
array = [1,2,3]

Sample Output:
[[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]
=cut

my @array = (1, 2, 3);
print(Dumper(&powerset(\@array)));

sub powerset {
	my ($array) = @_;
	my @subsets = ([]);
	for (@array) {
		my $element = $_;
		my $length = scalar @subsets;
		for (my $i=0; $i<$length; $i++) {
			my @temp = @{$subsets[$i]};
			push @temp, $element;
			push @subsets, \@temp;
		}
	}
	return \@subsets;
}



