#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Group Anagrams

Write a function that takes in an array of strings and groups anagrams together.

Anagrams are strings made up of exactly the same letters, where order doesn't matter.

For example, "cinema" and "iceman" are anagrams; similarly, "foo" and "ofo" are anagrams.

Your function should return a list of anagram groups in no particular order. 

Sample Input:
words = ["yo", "act", "flop", "tac", "foo", "cat", "oy", "olfp"]

Sample Output:
[["yo","oy"],["flop","olfp"],["act","tac","cat"],["foo"]]
=cut

my @array = ("yo", "act", "flop", "tac", "foo", "cat", "oy", "olfp");
print(Dumper(&groupAnagrams(\@array)));

sub groupAnagrams {
	my ($array) = @_;
	my $hash = {};
	my @result = ();
	for (@array) {
		my $currStr = $_;
		my $sortedStr = join "", sort split //, $currStr;
		if (exists $hash->{$sortedStr}) {
			push @{$hash->{$sortedStr}}, $currStr;
		} else {
			$hash->{$sortedStr} = [$currStr];
		}
	}
	my @result = values (%$hash);
	return \@result;
}

