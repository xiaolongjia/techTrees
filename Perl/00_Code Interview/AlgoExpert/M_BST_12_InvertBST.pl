#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Invert Binary Tree

Write a function that takes in a binary Tree and inverts it. In other words, the 
function should swap every left node in the tree for its corresponding right node.

Sample Input:
      1
    /   \
   2      3
  / \    / \
 4   5  6   7
/ \        
8  9

Sample Output: 
      1
    /   \
   3      2
  / \    / \
 7   6  5   4
           / \        
           9  8
=cut

package BinaryTree ;

sub new {
	my ($type, $value)=@_;
	my $self={};
	$self->{'value'} = $value;
	$self->{'left'} = NULL ;
	$self->{'right'} = NULL;
	bless $self,$type;
}

package main;

my $root = BinaryTree->new(1);
$root->{'left'} = BinaryTree->new(2);
$root->{'right'} = BinaryTree->new(3);
$root->{'left'}->{'left'} = BinaryTree->new(4);
$root->{'left'}->{'right'} = BinaryTree->new(5);
$root->{'right'}->{'left'} = BinaryTree->new(6);
$root->{'right'}->{'right'} = BinaryTree->new(7);
$root->{'left'}->{'left'}->{'left'} = BinaryTree->new(8);
$root->{'left'}->{'left'}->{'right'} = BinaryTree->new(9);

print(Dumper(invertBinaryTree($root)));

sub invertBinaryTree {
	my $tree = shift;
	my @queue = ($tree);
	while (scalar @queue > 0) {
		my $node = shift @queue;
		if ($node eq NULL) {
			next;
		}
		($node->{'left'}, $node->{'right'}) = ($node->{'right'}, $node->{'left'});
		push @queue, $node->{'left'};
		push @queue, $node->{'right'};
	}
	return $tree;
}

