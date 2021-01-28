#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Permutations 

Write a function that takes in an array of unique integers and returns an array of all 
permutations of those integers in no particular order. 

If the input array is empty, the function should return an empty array. 

Sample Input:
array = [1,2,3]

Sample Output:
[[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
=cut

my @array = (1, 2, 3, 4);
print(Dumper(&getPermutations(\@array)));

sub getPermutations {
	my ($array) = @_;
    my @permutations = ();
	my @currPermutations = ();
    &getPermutationsAction($array, \@currPermutations, \@permutations);
    return \@permutations;
}

sub getPermutationsAction {
	my ($array, $currPermutation, $permutations) = @_;
	my @data = @$array;
	if ((!@data) and @$currPermutation) {
		push @$permutations, [@$currPermutation];
	}
	else {
		for (my $i=0; $i<@data; $i++) {
			my @newArray = ();
			for (my $j = 0; $j<$i; $j++) {
				push @newArray, $data[$j];
			}
			for (my $j = $i+1; $j<@data; $j++) {
				push @newArray, $data[$j];
			}
			my @newPermutation = ();
			push @newPermutation, @$currPermutation;
			push @newPermutation, $data[$i];
			&getPermutationsAction(\@newArray, \@newPermutation, $permutations);
		}
	}
}



