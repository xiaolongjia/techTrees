#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;
use IO::Handle;

my @myArray = (2, 4, 6, 8);

# length of array $#myArray + 1
print("length is ".$#myArray."\n");

# slicing: index 1 and 3
my @newArray = @myArray[1,3];
print(Dumper(\@newArray));

# range operator: index 1, 2, 3
my @newArray = @myArray[1..3];
print(Dumper(\@newArray));





