#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Palindrome Check

Write a function that takes in a non-empty string and that returns a boolean representing
whether the string is a palindrome.

A palindrome is defined as a string that's written the same forward and backward. 
Note that single-character strings are palindromes. 

Sample Input:
string = "abcdcba"

Sample Output:
True
=cut

my $string = "abcdcba";
print(Dumper(&isPalindrome($string)));

sub isPalindrome {
	my ($string) = @_;
	return $string eq reverse($string);
}
