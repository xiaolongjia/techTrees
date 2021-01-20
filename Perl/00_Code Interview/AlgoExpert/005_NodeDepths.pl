#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
NodeDepths

The distance between a node in a Binary Tree and the tree's root is called the node's depth.

Write a function that takes in a Binary Tree and returns the sum of its node's depths.

Each BinaryTree node has an integer value, a left child node and a right child node.

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
16
// 16 = 1+1+2+2+2+2+3+3 

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
print(Dumper(&nodeDepths($root)));

sub nodeDepths {
	my ($root) = @_;
	my $depths = 0;
	&nodeDepthsRecursion($root, 0, \$depths);
	return $depths;
}

sub nodeDepthsRecursion {
	my ($node, $currDepth, $depths) = @_;
	if ($node eq NULL) {
		return ;
	}
	$$depths +=  $currDepth ;
	&nodeDepthsRecursion($node->{'left'},   $currDepth + 1 , $depths);
	&nodeDepthsRecursion($node->{'right'},  $currDepth + 1 , $depths);
}


