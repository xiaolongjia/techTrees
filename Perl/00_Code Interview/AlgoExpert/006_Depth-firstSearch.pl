#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Depth-firstSearch

You are given a Node class that has a name and an array of optional children nodes.
When put together, nodes form an acyclic tree-like structure.

Implement the depthFirstSearch method on the Node class, which takes in an empty array.
traverses the tree using the depth-first-search approach (specifically navigating the tree from 
left to right), stores all of the nodes' names in the input array, and returns it.

Sample input:
graph =  10
       /   \
       5    15
      /\   /   \
     2  5  13  22 
    /        \
   1          14     

Sample output:
[10, 5, 2, 1, 5, 15, 13, 14, 22]

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
print(Dumper(&depthFirstSearch($root)));

sub depthFirstSearch {
	my ($root) = @_;
	my @elements = ();
	&depthFirstSearchRecursion($root, \@elements);
	return \@elements;
}

sub depthFirstSearchRecursion {
	my ($node, $result) = @_;
	if ($node eq NULL) {
		return ;
	}
	push @$result, $node->{'value'} ;
	&depthFirstSearchRecursion($node->{'left'},   $result);
	&depthFirstSearchRecursion($node->{'right'},  $result);
}


