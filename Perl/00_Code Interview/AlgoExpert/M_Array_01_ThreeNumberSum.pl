#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Three Number Sum 

Write a function that takes in a non-empty array of distinct integers and an integers
representing a target sum. The function should find all triplets in the array that sum up to 
the target sum and return a two-dimensional array of all these triplets. The numbers in each triplet
should be ordered in ascending order. and the triplets themselves should be ordered 
in ascending order with respect to the numbers they hold. 

if no three numbers sum up to the target sum, the function should return an empty array. 

Sample Input:
array = [12, 3, 1, 2, -6, 5, -8, 6]
targetSum = 0

Sample Output:
[[-8, 2, 6], [-8, 3, 5], [-6, 1, 5]]
=cut

my @array = (12, 3, 1, 2, -6, 5, -8, 6);
my $targetSum = 0;

print(Dumper(&threeNumberSum(\@array, $targetSum)));

sub threeNumberSum {
	my ($array, $targetSum) = @_;
	my @data = sort {$a <=> $b} @$array;
	my @result = ();
	
	for (my $i=0; $i<= $#data-2; $i++) {
		my $base = $data[$i];
		my $left = $i+1;
		my $right = $#data;
		while ($left < $right) {
			my $currSum = $data[$left] +$data[$right] + $base;
			if ($targetSum > $currSum) {
				$left += 1;
			} elsif ($targetSum < $currSum) {
				$right -= 1;
			} else {
				my @temp = ($base, $data[$left], $data[$right]);
				push @result, \@temp;
				$left += 1;
				$right -=1;
			}
		}
	}
	return \@result;
}

