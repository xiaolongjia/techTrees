#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Balanced Brackets

Write a function that takes in a string made up of brackets (, [, {,),],}
and other optional characters. The function should return a boolean representing 
whether the string is balanced with regards to brackets.

A string is said to be balanced if it has as many opening brackets of a certain type
as it has closing brackets of that type and if no bracket is unmacthed. Note that 
an opening bracket cannot math a corresponding closing bracket that comes before it. 
and similarly, a closing bracket cannot match a corresponding opening bracet that comes 
after it. Also, brackets cannot overlap each other as in [(])

Sample Input:
string = "([])(){}(())()()"

Sample Output:
true // it's balanced
=cut

my $string = "([])(){}(())()()";
print(&balancedBrackets($string));

sub balancedBrackets { 
	my ($string) = @_;
	my $openBrackets = {'['=>']', '{'=>'}', '('=>')'};
	my $closeBrackets = {']'=>'[', '}'=>'{', ')'=>'('};
	my @stack = ();
	my @myStr = split//,$string;
	for (@myStr) {
		my $currStr = $_;
		if (exists $openBrackets->{$currStr}) {
			push @stack, $currStr;
			next;
		}
		if (exists $closeBrackets->{$currStr}) {
			my $matchedOpen = $closeBrackets->{$currStr};
			my $lastOpen = pop @stack;
			if ($matchedOpen ne $lastOpen) {
				return 0;
			}
		}
	}
	return (scalar @stack > 0) ? 0 : 1;
}

