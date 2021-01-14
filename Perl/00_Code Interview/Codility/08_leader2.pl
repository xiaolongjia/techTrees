#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A non-empty array A consisting of N integers is given.

The leader of this array is the value that occurs in more than half of the elements of A.

An equi leader is an index S such that 0 ¡Ü S < N ? 1 and two sequences A[0], A[1], ..., A[S] and A[S + 1], A[S + 2], ..., A[N ? 1] have leaders of the same value.

For example, given array A such that:

    A[0] = 4
    A[1] = 3
    A[2] = 4
    A[3] = 4
    A[4] = 4
    A[5] = 2
we can find two equi leaders:

0, because sequences: (4) and (3, 4, 4, 4, 2) have the same leader, whose value is 4.
2, because sequences: (4, 3, 4) and (4, 4, 2) have the same leader, whose value is 4.
The goal is to count the number of equi leaders.

Write a function:

sub solution { my (@A)=@_; ... }

that, given a non-empty array A consisting of N integers, returns the number of equi leaders.

For example, given:

    A[0] = 4
    A[1] = 3
    A[2] = 4
    A[3] = 4
    A[4] = 4
    A[5] = 2
the function should return 2, as explained above.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [1..100,000];
each element of array A is an integer within the range [?1,000,000,000..1,000,000,000].
=cut

my @A = (4, 3, 4, 4, 4, 2, 4);

print(&solution(\@A));

sub solution {
	my $data = shift;
	my @data = @$data;
	my $myhash = {};
	for (my $i=0; $i<@data; $i++) {
		if (exists $myhash->{$data[$i]}) {
			push @{$myhash->{$data[$i]}}, $i;
		}
		else {
			@{$myhash->{$data[$i]}} = ($i);
		}
	}
	my $half = @data/2;
	my $flag = 0;
	my @result;
	foreach my $currKey (keys %$myhash) {
		my $length = scalar @{$myhash->{$currKey}};
		if ($length > $half) {
			@result = @{$myhash->{$currKey}};
			$flag = 1;
		}
	}
	my $eqLeader = 0;
	if ($flag) {
		for (my $i=0; $i<@result; $i++) {
			if ((($i+1>($result[$i]+1)/2)) and ($#result-$i>($#data-$result[$i])/2)) {
				$eqLeader += 1;
			}
		}
	}
	return $eqLeader;
}
