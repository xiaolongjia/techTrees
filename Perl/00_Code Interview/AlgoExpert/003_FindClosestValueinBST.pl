#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Find Closest Value in BST

Write a function that takes in a Binary Search Tree(BST) and a target integer value and returns the closest value to that target value contained in the BST.

You can assume that there will only be one closest value.

Each BST node has an integer value, a left child node, and a right child node. A node is said to be a valid BST if and only if it satisfies the BST propertities:
its value is strictly greater than the values of every node to its left;
its value is less than or equal to the values of every node to its right;
and its children nodes are either valid BST nodes themselves or None/Null.

Sample input:
tree =  10
       /   \
       5    15
      /\   /   \
     2  5  13  22 
    /        \
   1          14
target = 12

Sample output:
13

iteratively , recursively
=cut

package BST ;

sub new {
	my ($type, $value)=@_;
	my $self={};
	$self->{'value'} = $value;
	$self->{'left'} = NULL ;
	$self->{'right'} = NULL;
	bless $self,$type;
}

package main;

my $root = BST->new(10);
my $bst5 = BST->new(5);
my $bst15  = BST->new(15);
my $bst2   = BST->new(2);
my $bst52  = BST->new(5);
my $bst13  = BST->new(13);
my $bst22  = BST->new(22);
my $bst1   = BST->new(1);
my $bst14  = BST->new(14);
$root->{'left'} = $bst5;
$root->{'right'} = $bst15;
$bst5->{'left'} = $bst2;
$bst5->{'right'} = $bst52;
$bst15->{'left'} = $bst13;
$bst15->{'right'} = $bst22;
$bst2->{'left'} = $bst1;
$bst13->{'right'} = $bst14;
print(&findClosestValueInBst($root, 16));

sub findClosestValueInBst {
	my ($tree, $target) = @_;
	return &findClosestValueInBstRecursion($tree, $target, $tree->{'value'});
}

sub findClosestValueInBstRecursion {
	my ($node, $target, $closedValue) = @_;
	if ($node eq NULL) {
		return $closedValue;
	}
	$value = $node->{'value'};
	if (abs($target - $value) < abs($target - $closedValue)) {
		$closedValue = $value;
	}
	if ($value > $target) {
		return &findClosestValueInBstRecursion($node->{'left'}, $target, $closedValue);
	} elsif ($value < $target) {
		return &findClosestValueInBstRecursion($node->{'right'}, $target, $closedValue);
	} else {
		return $closedValue;
	}
}

