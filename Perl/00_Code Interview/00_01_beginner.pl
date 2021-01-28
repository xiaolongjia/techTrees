#!C:\r\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;
use IO::Handle;
#use Alias qw(alias const attr);

# $_
foreach ('Mango', 'Orange', 'Apple') 
{ 
   print($_."\n"); 
} 

# system()
print(system("dir"),"\n");

# fork()
$retval = fork();
if ($retval ==0) {
	print("this is in child process\n");
	exit(1);
} else {
	print("parent process existed.\n");
}

$subinfo = caller(); 
print($subinfo);

$timelist = times();
print($timelist);

# index 
my $string = "good moLring!";
my $substring = "oo";
print(index($string, $substring, 1),"\n");

# length
print(length("hello!"),"\n");

# pos 
$string =~ m/L/g;
print(pos($string),"\n");

# substr
print(substr($string, 2, 4),"\n");

# join 
my @string = ("hah\na", "tim", "jia");
print(join("|", @string),"\n");

# sprintf
$num = 26;
$outstr = sprintf("%d = %x hexadecimal or %o octal\n",$num, $num, $num);
print ($outstr); 

# chop()
print($#string,"\n");
print ("Size: ",scalar @string,"\n");

chop(@string);
print(Dumper(\@string));

# chomp()
chomp(@string);
print(Dumper(\@string));

# crypt()
print(crypt($mystring, "19"),"\n");
print(crypt($mystring, "18"),"\n");

# array slicing and range operator 
@myArray = (2,4,6,8,10, 12, 123);

# grep()
@grepArray = grep(/2/, @myArray);
print(Dumper(\@grepArray));

# my, local 
local $uustring = "local variable";
{
	my $uustring = "my variable";
	print("in block is:".$uustring."\n");  # output: in block is:my variable
	print("local block is:".$::uustring."\n"); # output: local block is:local variable
}

# polymorphism 

package X;
sub foo {
	print("Inside X::foo\n");
}

package Z;
@ISA = (X);
sub foo {
	print("Inside Z::foo\n");
}

package main;
Z->foo();

# symbol tables 
print(Dumper(\%Foo::));

# alias 
$spud = "Wow!"; 
@spud = ("idaho", "russet"); 
*potato = *spud; # Alias potato to spud using typeglob assignment 
print "$potato\n"; # prints "Wow!" 
print @potato, "\n"; # prints "idaho russet"
exit;




# re
my $trString = "AasdasdBasdAsadCAsdsadA";
my $counter = ($trString =~ s/A//g);
print($counter."\n".$trString."\n");

# remove duplicate value 
my @array = (1, 2, 4, 3, 2, 3, 1, 2, 5);
print join(" ", @array), "\n";
print join(" ", keys %{{ map { $_ => 1 } @array }}), "\n";

# STDIN STDOUT STDERR
my $input = <STDIN>;
print($input);








