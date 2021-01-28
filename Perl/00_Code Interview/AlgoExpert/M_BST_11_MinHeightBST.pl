#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Min Height BST

Write a function that takes in a non-empty sorted array of distinct integers, constructs a BST
from the integers, and returns the root of the BST. The function should minimize the height of the BST.

Sample Input:
array = [1,2,5,7,10,13,14,15,22]
Sample Output: 
     10
    /   \
   2     14
  / \    / \
 1   5  13  15
     \        \
     7        22
OR:
      10
    /    \
   5     15
  / \    /  \
 2   7  13  22
/       \
1        14
=cut


package BST ;
use Data::Dumper;

sub new {
	my ($type, $value)=@_;
	my $self={};
	$self->{'value'} = $value;
	$self->{'left'} = NULL ;
	$self->{'right'} = NULL;
	bless $self,$type;
}

sub insert {
	my ($self, $value)=@_;
	if ($self->{'value'} > $value) {
		if ($self->{'left'} eq NULL) {
			$self->{'left'} = BST->new($value);
		}
		else {
			$self->{'left'}->insert($value);
		}
	} else {
		if ($self->{'right'} eq NULL) {
			$self->{'right'} = BST->new($value);
		}
		else {
			$self->{'right'}->insert($value);
		}
	}
}


package main;

my @array = (1,2,5,7,10,13,14,15,22);
print(Dumper(minHeightBst(\@array)));

sub minHeightBst {
	my $array = shift ;
	my @data = @$array;
	return &buildMinHeighBst($array, 0, $#data, '')
}

sub buildMinHeighBst {
	my $array = shift;
	my $start = shift;
	my $end = shift;
	my $node = shift;
	if ($start > $end) {
		return;
	}
	my $middle = int(($start + $end)/2);
	if (!$node) {
		$node = BST->new(@$array[$middle]);
	} else {
		$node->insert(@$array[$middle]);
	}
	&buildMinHeighBst($array, $start, $middle-1, $node);
	&buildMinHeighBst($array, $middle+1, $end, $node);
	return $node;
}

