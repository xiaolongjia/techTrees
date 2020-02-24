#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;

=begin
A string S consisting of N characters is considered to be properly nested if any of the following conditions is true:

S is empty;
S has the form "(U)" or "[U]" or "{U}" where U is a properly nested string;
S has the form "VW" where V and W are properly nested strings.
For example, the string "{[()()]}" is properly nested but "([)()]" is not.

Write a function:

sub solution { my ($S)=@_; ... }

that, given a string S consisting of N characters, returns 1 if S is properly nested and 0 otherwise.

For example, given S = "{[()()]}", the function should return 1 and given S = "([)()]", the function should return 0, as explained above.

Write an efficient algorithm for the following assumptions:

N is an integer within the range [0..200,000];
string S consists only of the following characters: "(", "{", "[", "]", "}" and/or ")".
=cut

my $S = "([)()]";
#my $S = "{[()()]}";

print(&solution($S));

sub solution {
	my $s = shift;
	my @data = split//,$s;
	my @stack = ();
	my %pairs = ("{"=>"}", "}"=>"{", "("=>")",")"=>"(","["=>"]","]"=>"[");
	for (my $i=0; $i<@data; $i++) {
		if (@stack > 0) {
			if ($pairs{$data[$i]} eq $stack[$#stack]) {
				pop @stack;
			}
			else {
				push @stack, $data[$i];
			}
		}
		else {
			push @stack, $data[$i];
		}
	}
	if (@stack > 0) {
		return 0;
	}
	else {
		return 1;
	}
}
