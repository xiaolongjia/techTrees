#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A small frog wants to get to the other side of the road. The frog is currently located at position X and wants to get to a position greater than or equal to Y. The small frog always jumps a fixed distance, D.

Count the minimal number of jumps that the small frog must perform to reach its target.

Write a function:

sub solution { my ($X, $Y, $D)=@_; ... }

that, given three integers X, Y and D, returns the minimal number of jumps from position X to a position equal to or greater than Y.

For example, given:

  X = 10
  Y = 85
  D = 30
the function should return 3, because the frog will be positioned as follows:

after the first jump, at position 10 + 30 = 40
after the second jump, at position 10 + 30 + 30 = 70
after the third jump, at position 10 + 30 + 30 + 30 = 100
Write an efficient algorithm for the following assumptions:

X, Y and D are integers within the range [1..1,000,000,000];
X ¡Ü Y.
=cut

print(&solution(10, 85, 30));

sub solution {
	my ($X, $Y, $D) = @_; 
	my $distance = $Y - $X;
	my $counter = int($distance/$D);
	my $left = $distance%$X;
	if ($left) {
		return ($counter+1);
	}
	else {
		return ($counter);
	}
}
