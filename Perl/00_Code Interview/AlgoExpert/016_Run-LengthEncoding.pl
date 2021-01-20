#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Run-Length Encoding

Write a function that takes in a non-empty string and returns its run-length encoding.

From Wikipedia, "run-length encoding is a form of lossless data compression in whcih runs of data are stored as a single data value and count, 
rather than as the original run.". For this problem, a run of data is any sequence of consecutive, 
identical character. So the run 'AAA' would be run-length-encoded as '3A'

To make things more complicated, however, the input string can contain all sorts of special characters, 
including numbers. And since encoded data must be decodable, this means that we 
cannot naively run-length-encode long runs. For example, the run 
'AAAAAAAAAAAAA' (12A), cannot naively be encoded as '12A', since this string can be decoded as either 
'AAAAAAAAAAAAA' or '1AA', Thus, long runs (runs of 10 or more characters) should be encoded in a split fashion;
the aforementioned run should be decoded as '9A3A' 

Sample Input:
string = "AAAAAAAAAAAAABBCCCCDD"

Sample Output:
"9A4A2B4C2D"
=cut

my $string = "AAAAAAAAAAAAABBCCCCDD";
print(Dumper(&runLengthEncoding($string)));

sub runLengthEncoding {
	my ($string) = @_;
	my @myStr = split//,$string;
	my $newStr = "";
	my $currChar = $myStr[0];
	my $counter = 1;
	for(my $i=1; $i<=$#myStr; $i++) {
		if ($myStr[$i] eq $currChar) {
			if ($counter <9) {
				$counter += 1;
			}
			else {
				$newStr .= "9".$currChar;
				$counter = 1;
			}
		} else {
			$newStr .= $counter.$currChar;
			$counter = 1;
			$currChar = $myStr[$i];
		}
	}
	$newStr .= $counter.$currChar;
	return $newStr;
}
