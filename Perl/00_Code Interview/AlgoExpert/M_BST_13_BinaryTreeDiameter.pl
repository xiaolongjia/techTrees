#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Binary Tree Diameter 

Write a function that takes in a binary Tree and return its diameter.
The diameter of a binary tree is defined as the length of its longest path.
even if that path does not pass through the root of the tree. 

A path is a collection of connected nodes in a tree, where no node is connected to more than two
other nodes. The length of a path is the number of edges between the path's first node 
and its last node. 

Sample Input:
           1
         /   \
        3     2
       / \   
      7   4 
     /     \        
    8       5 
    /        \
   9          6
  
Sample Output: 
6 // 9->8->7->3->4->5>6
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

package treeInfo ; 

sub new {
	my ($type, $height, $diameter)=@_;
	my $self={};
	$self->{'height'} = $height;
	$self->{'diameter'} = $diameter ;
	bless $self,$type;
}

package main;

my $root = BinaryTree->new(1);
$root->{'left'} = BinaryTree->new(3);
$root->{'right'} = BinaryTree->new(2);
$root->{'left'}->{'left'} = BinaryTree->new(7);
$root->{'left'}->{'left'}->{'left'} = BinaryTree->new(8);
$root->{'left'}->{'left'}->{'left'}->{'left'} = BinaryTree->new(9);
$root->{'left'}->{'right'} = BinaryTree->new(4);
$root->{'left'}->{'right'}->{'right'} = BinaryTree->new(5);
$root->{'left'}->{'right'}->{'right'}->{'right'} = BinaryTree->new(6);

my $info = &binaryTreeDiameter($root);
print($info->{'diameter'});

sub getTreeInfo {
	my $tree = shift;	
	if ($tree eq NULL) {
		return treeInfo->new(0, 0);
	}
	my $leftTreeInfo = &getTreeInfo($tree->{'left'});
	my $rightTreeInfo = &getTreeInfo($tree->{'right'});
	my $pathWithRoot = $leftTreeInfo->{'height'} + $rightTreeInfo->{'height'};
	my $pathWithoutRoot = ($leftTreeInfo->{'diameter'} > $rightTreeInfo->{'diameter'}) ? $leftTreeInfo->{'diameter'} : $rightTreeInfo->{'diameter'};
	my $currDiameter = ($pathWithRoot > $pathWithoutRoot) ? $pathWithRoot : $pathWithoutRoot ;
	my $currHeight = (($leftTreeInfo->{'height'} > $rightTreeInfo->{'height'}) ? $leftTreeInfo->{'height'} : $rightTreeInfo->{'height'})+1;
	#print("tree value:".$tree->{'value'}."\t currDiameter: $currDiameter \t currHeight: $currHeight \n");
	return treeInfo->new($currHeight, $currDiameter);
}

sub binaryTreeDiameter {
	my $tree = shift;
	return &getTreeInfo($tree);
}


