#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
BST Traversal

Write three functions that takes in a Binary Search Tree(BST) and an empty array.
traverse the BST. add its nodes' values to the input array, and return that array.
The three functions should traverse the BST using the in-order, pre-order, and post-order
tree-traversal techniques, respectively. 

Sample Input:
     10
    /   \
   5     15
  / \     \
  2  5    22
 /       
1       

Sample Output: 
preOrderTraverse: [10, 5, 2, 1, 5, 15, 22] # Preorder  (Root, Left, Right) 
inOrderTraverse: [1,2,5,5,10,15,22]        # Inorder   (Left, Root, Right) 
postOrderTraverse: [1,2,5,5,22,15,10]      # Postorder (Left, Right, Root) 
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

sub preOrderTraverse {
	my $self = shift ;
	my $node = shift;
	my $result = shift;
	my @tmp = ();
	if (!$result) {	
		$result = \@tmp;
	}
	if ($node eq NULL) {
		return ;
	}
	push @$result, $node->{'value'};
	$self->preOrderTraverse($node->{'left'}, $result);
	$self->preOrderTraverse($node->{'right'}, $result);
	return $result;
}

sub inOrderTraverse {
	my $self = shift ;
	my $node = shift;
	my $result = shift;
	my @tmp = ();
	if (!$result) {	
		$result = \@tmp;
	}
	if ($node eq NULL) {
		return ;
	}
	$self->inOrderTraverse($node->{'left'}, $result);
	push @$result, $node->{'value'};
	$self->inOrderTraverse($node->{'right'}, $result);
	return $result;
}

sub postOrderTraverse {
	my $self = shift ;
	my $node = shift;
	my $result = shift;
	my @tmp = ();
	if (!$result) {	
		$result = \@tmp;
	}
	if ($node eq NULL) {
		return ;
	}
	$self->postOrderTraverse($node->{'left'}, $result);
	$self->postOrderTraverse($node->{'right'}, $result);
	push @$result, $node->{'value'};
	return $result;
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
print(Dumper($root->preOrderTraverse($root)));
print(Dumper($root->inOrderTraverse($root)));
print(Dumper($root->postOrderTraverse($root)));
