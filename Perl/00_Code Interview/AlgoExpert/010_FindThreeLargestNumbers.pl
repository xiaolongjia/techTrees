#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Find Three Largest Numbers 

Write a function that takes in an array of at least three integers and, without sorting the input array. 

returns a sorted array of the three largest integers in the input array. 

The function should return duplicate integers if necessary: for example, it should 

return [10, 10, 12] for an input array of [10, 5, 9, 10, 12]

Sample Input:
array = [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]

Sample Output:
[18, 141, 541]
=cut

my @array = (141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7);
print(Dumper(&findThreeLargestNumbers(\@array)));

sub findThreeLargestNumbers {
	my ($array) = @_;
	my @tArray = @$array;
	my @result = ('NULL', 'NULL', 'NULL');
	for (@tArray) {
		my $number = $_;
		if ($result[2] eq 'NULL' or $number > $result[2]) {
			&shiftArray(\@result, 2, $number);
		} elsif ($result[1] eq 'NULL' or $number > $result[1]) {
			&shiftArray(\@result, 1, $number);
		} elsif ($result[0] eq 'NULL' or $number > $result[0]) {
			&shiftArray(\@result, 0, $number);
		}
	}
	return \@result;
}

sub shiftArray {
	my ($array, $index, $value) = @_;
	for (my $i=0; $i<$index; $i++) {
		@$array[$i] = @$array[$i+1];
	}
	@$array[$index] = $value;
}