#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Longest Palindromic Substring

Write a function that, given a string, returns its longest palindromic substring.

You can assuem that there will only be one longest palindromic substring. 

Sample Input:
string = "abaxyzzyxf"

Sample Output:
"xyzzyx"
=cut

my $string = "abaxyzzyxf";
print(Dumper(&longestPalindromicSubstring($string)));

sub longestPalindromicSubstring {
	my ($string) = @_;
	my @myStr = split//,$string;
	my $length = scalar @myStr;
	my $longestPalindromicLength = 0;
	my $longestPalindromicStr = '';
	
	if ($length <=1) {
		return $string;
	} elsif ($length == 2) {
		if ($myStr[0] == $myStr[1]) {
			return $string;
		} else {
			return $myStr[0];
		}
	} else {
		for (my $i=1; $i<$length; $i++) {
			if ($myStr[$i-1] eq $myStr[$i+1]) {
				my ($start, $end) = &findPalindromic($i-1, $i+1, \@myStr);
				my $currLength = $end - $start + 1;
				if ( $currLength > $longestPalindromicLength) {
					$longestPalindromicLength = $currLength;
					$longestPalindromicStr = substr($string, $start, $currLength);
					print($start,"\t", $end, "\t", $longestPalindromicStr, "\n");
				}
			}
			if ($myStr[$i-1] eq $myStr[$i]) {
				my ($start, $end) = &findPalindromic($i-1, $i, \@myStr);
				my $currLength = $end - $start + 1;
				if ( $currLength > $longestPalindromicLength) {
					$longestPalindromicLength = $currLength;
					$longestPalindromicStr = substr($string, $start, $currLength);
					print($start,"\t", $end, "\t", $longestPalindromicStr, "\n");
				}
			}
		}
		return $longestPalindromicStr;
	}
}

sub findPalindromic {
	my ($start, $end, $array) = @_;
	my $length = scalar @{$array};
	while ($start>=0 and $end < $length) {
		if ($array->[$start] eq $array->[$end]) {
			$start -=1;
			$end +=1;
		} else {
			last;
		}
	}
	return ($start+1, $end-1);
}
