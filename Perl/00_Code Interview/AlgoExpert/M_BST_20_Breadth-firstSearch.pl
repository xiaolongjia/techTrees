#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Breadth-first Search

You are given a Node class that has a name and an array of optional children nodes.
When put together, nodes form an acyclic tree-like structure.

Implement the breadth-first search method on the Node class, which takes in an empty array.
traverses the tree using the Breadth-first search approach (specifically navigating the 
tree from left to right), stores all of the nodes' names in the input array, and returns it.

Sample Input:
       A
    /  |   \
   B   C    D
  / \      /  \
 E  F     G   H 
   / \     \      
  I   J    K     

Sample Output: 
[A,B,C,D,E,F,G,H,I,J,K]
=cut

package BinaryTree ;

sub new {
	my ($type, $name)=@_;
	my $self={};
	$self->{'name'} = $name;
	$self->{'children'} = [] ;
	bless $self,$type;
}

sub addChildren {
	my ($self, $name)=@_;
	push @{$self->{'children'}}, BinaryTree->new($name);
}

sub breadthFirstSearch {
	my ($self)=@_;
	my @children = @{$self->{'children'}};
	my @result = ($self->{'name'});
	while (@children) {
		my $currChild = shift @children;
		push @result, $currChild->{'name'};
		push @children, @{$currChild->{'children'}};
	}
	return \@result;
}

package main;

my $root = BinaryTree->new("A");
my $nodeB = BinaryTree->new("B");
my $nodeC = BinaryTree->new("C");
my $nodeD = BinaryTree->new("D");
my $nodeE = BinaryTree->new("E");
my $nodeF = BinaryTree->new("F");
my $nodeG = BinaryTree->new("G");
my $nodeH = BinaryTree->new("H");
my $nodeI = BinaryTree->new("I");
my $nodeJ = BinaryTree->new("J");
my $nodeK = BinaryTree->new("K");
$root->{'children'} = [$nodeB, $nodeC, $nodeD];
$nodeB->{'children'} = [$nodeE, $nodeF];
$nodeD->{'children'} = [$nodeG, $nodeH];
$nodeF->{'children'} = [$nodeI, $nodeJ];
$nodeG->{'children'} = [$nodeK];

print(Dumper($root->breadthFirstSearch()));

