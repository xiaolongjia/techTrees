#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Array of products

Write a function that takes in a non-empty array of integers and returns an array of the same length, 
where each element in the output array is equal to the product of every other number in the input array. 

In other words, the value at output[i] is equal to the product of every number in the input 
array other than input[i].

Note that you're expected to solve this problem without using division. 

Sample Input:
array = [ 5, 1, 4, 2]

Sample Output:
[8, 40, 10, 20]
=cut

my @array = (2, 1, 3, 1, 2);
print(Dumper(&arrayOfProducts(\@array)));

sub arrayOfProducts {
	my ($array) = @_;
	my @data =  @$array;
	my @result = map(1, @data);

	my $runningProd = 1;
	for (my $i=1; $i<= $#data; $i++) {
		$runningProd *= $data[$i-1];
		$result[$i] = $runningProd;
	}
	$runningProd = 1;
	for (my $i=$#data-1; $i>=0 ; $i--) {
		$runningProd *= $data[$i+1];
		$result[$i] *= $runningProd;
	}
	return \@result;
}
