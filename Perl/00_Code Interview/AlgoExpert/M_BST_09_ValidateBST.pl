#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Validate BST

Write a function that takes in a potentially invalid Binary Search Tree (BST) and 
return a boolean representing whether the BST is valid. 

Each BST node has an integer value, a left child node, and a right child node. 
A node is said to be a valid BST node if and only if it satisfies the BST property:
its value is strictly greater than the values of every node to its left;
its value is less than or equal to the values of every node to its right;
and its children nodes are either valid BST nodes themselves or NONE/NULL

a BST is valid if and only if all of its nodes are valid BST nodes. 

Sample Input:
     10
    /   \
   5     15
  / \   /  \
  2  5  13  22
 /       \
 1       14

Sample Output: True
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

#print(Dumper($root));
print(Dumper(&validateBst($root)));

sub validateBst {
	my $node = shift;
	return validateBstRecursion($node, -2**53, 2**53);
}

sub validateBstRecursion {
	my ($node, $minValue, $maxValue) = @_;
	if ($node eq NULL) {
		return 1 ;
	}
	if ($node->{'value'} < $minValue or $node->{'value'} > $maxValue) {
		return 0;
	}
	my $leftResult =  validateBstRecursion($node->{'left'}, -2**53, $node->{'value'});
	my $rightResult =  validateBstRecursion($node->{'right'}, $node->{'value'},  2**53);
	return ($leftResult == $rightResult ? 1: 0);
}
