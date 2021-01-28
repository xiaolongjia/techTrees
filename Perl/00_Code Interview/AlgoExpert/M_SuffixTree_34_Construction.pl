#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Suffix Trie Construction 

Write a Suffix Trie class for a Suffix-Trie-like data structure. The class should 
have a root property set to be the root node of the trie and should support:
- creating the trie from a string; this will be done by calling the 
populate SuffixTrie From method upon class instantiation, which should populate 
the root of the class 
- searching for strings in the trie. 

Note that every string added to the trie should end with the special endSymbol character 
"*"

Sample Input:
string = "babc"

Sample Output:
{
"c": {"*": true},
"b": {
    "c": {"*": true},
    "a": {"b": {"c": {"*": true}}},
},
"a": {"b": {"c": {"*": true}}}
}
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

