#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
Write a function:

sub solution { my (@A)=@_; ... }

that, given an array A of N integers, returns the smallest positive integer (greater than 0) that does not occur in A.

For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.

Given A = [1, 2, 3], the function should return 4.

Given A = [?1, ?3], the function should return 1.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..100,000];
each element of array A is an integer within the range [?1,000,000..1,000,000].
=cut

#my @A = (1, 3, 1, 4, 6, -3, -2, -1);
#my @A = (-1, -3, 8, -4, -6, -3, -2, -1);
my @A = (-1, -3, 1, 8, -4, -6, -3, -2, -1);
print(&solution(\@A));

sub solution {
	my $data = shift;
	my @data = @$data;
	my %count = ();
	my @removeNegative = grep { $_ > 0 } @data;
	print(Dumper(@removeNegative));
	if (@removeNegative > 0) {
		my @removeRepeat = grep { ++$count{$_} == 1} @removeNegative;
		print(Dumper(@removeRepeat));
		my @newdata = sort @removeRepeat;
		if ($newdata[0] > 1) {
			return 1;
		}
		else {
			if (@newdata > 1) {
				for (my $i=0; $i<@newdata-1; $i++) {
					if ($newdata[$i+1] - $newdata[$i] > 1) {
						return $newdata[$i]+1;
					}
				}
			}
			else {
				return $newdata[0]+1;
			}
		}
	}
	else {
		return 1;
	}
}
