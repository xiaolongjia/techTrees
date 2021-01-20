#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Branch Sums 

Write a function that takes in a Binary Tree and returns a list of its branch sums ordered from 
leftmost branch sum to rightmost branch sum.

A branch sum is the sum of all values in a Binary Tree branch. A Binary Tree branch is a path
of nodes in a tree that starts at the root node and ends at any leaf node.

Each BinaryTree node has an integer value. a left child node, and a right child node.
Children nodes can either be BinaryTree nodes themselves or None/Null.

Sample input:
tree =  10
       /   \
       5    15
      /\   /   \
     2  5  13  22 
    /        \
   1          14
   
Sample output:
[18, 20, 52, 47]
// 18 = 10+5+2+1
// ...

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
print(Dumper(&branchSums($root)));

sub branchSums {
	my ($root) = @_;
	my @sums = ();
	&branchSumsRecursion($root,  0, \@sums);
	return \@sums;
}

sub branchSumsRecursion {
	my ($node, $currSum, $result) = @_;
	if ($node eq NULL) {
		return ;
	}
	
	$mySum =  $node->{'value'} + $currSum;
	if ($node->{'left'} eq NULL and $node->{'right'} eq NULL) {
		push @$result , $mySum;
		return ;
	}
	&branchSumsRecursion($node->{'left'},   $node->{'value'} + $currSum , $result);
	&branchSumsRecursion($node->{'right'},  $node->{'value'} + $currSum , $result);
}


