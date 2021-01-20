#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Caesar Cipher Encryptor

Given a non-empty string of lowercase letters and a non-negative integer representing a key, write a function
that returns a new string obtained by shifting every letter in the input string by k positions in the alphabet,
where k is the key.

Note that letters should "wrap" around the alphabet; in order words, the letter z shifted by one 
returns the letter a. 

Sample Input:
string = "xyz"
key = 2

Sample Output:
"zab"
=cut

my $string = "xyz";
print(Dumper(&caesarCipherEncryptor($string, 2)));

sub caesarCipherEncryptor {
	my ($string, $key) = @_;
	my @myStr = split//,$string;
	my $newStr = "";
	for(@myStr) {
		my $char = $_;
		my $charAscii = ord($char) + $key;
        my $nextChar = $charAscii <= 122 ?  chr($charAscii) : chr(96+$charAscii%122);
		$newStr .= $nextChar;
		print($char."->".$nextChar."\n");
	}
	return $newStr;
}
