#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Youngest Common Ancestor

You are given three inputs, all of which are instances of an AncestralTree class that 
have an ancestor property pointing to their youngest ancestor. The first input is the top
ancestor in an ancestral tree (i.e., the only instance that has no ancestor -- its 
ancestor property points to None / null), and the other two inputs are descendants in the 
ancestral tree. 

Write a function that returns the youngest common ancestor to the two descendants.

Note that a descendant is considered its own ancestor. So in the simple ancestral tree below,
the youngest common ancestor to nodes A and B is node A.
     A 
    /
   B 

Sample Input:
topAncestor: node A 
descendantOne: node E 
descendantTwo: node I 
       A
     /   \
    B     C
   / \   /  \
  D   E F    G 
 / \          
H   I

Sample Output: 
node B 
=cut

package AncestralTree ;

sub new {
	my ($type, $name)=@_;
	my $self={};
	$self->{'name'} = $name;
	$self->{'ancestor'} = '';
	bless $self,$type;
}

package main;

my $root  = AncestralTree->new("A");
my $nodeB = AncestralTree->new("B");
my $nodeC = AncestralTree->new("C");
my $nodeD = AncestralTree->new("D");
my $nodeE = AncestralTree->new("E");
my $nodeF = AncestralTree->new("F");
my $nodeG = AncestralTree->new("G");
my $nodeH = AncestralTree->new("H");
my $nodeI = AncestralTree->new("I");
$nodeB->{'ancestor'} = $root;
$nodeC->{'ancestor'} = $root;
$nodeD->{'ancestor'} = $nodeB;
$nodeE->{'ancestor'} = $nodeB;
$nodeF->{'ancestor'} = $nodeC;
$nodeG->{'ancestor'} = $nodeC;
$nodeH->{'ancestor'} = $nodeD;
$nodeI->{'ancestor'} = $nodeD;

print(Dumper(&getYoungestCommonAncestor($root, $nodeH, $nodeI)));

sub getYoungestCommonAncestor {
	my ($top, $nodeOne, $nodeTwo) = @_;
	my $heightOne = &getHeight($top, $nodeOne);
	my $heightTwo = &getHeight($top, $nodeTwo);
	my $distance = abs($heightOne - $heightTwo);
	my $longNode = ($heightOne > $heightTwo) ? $nodeOne : $nodeTwo;
	my $nearNode = ($heightOne > $heightTwo) ? $nodeTwo : $nodeOne;
	while ($distance > 0 ) {
		$longNode = $longNode->{'ancestor'};
		$distance -= 1;
	}
	while ($longNode != $nearNode) {
		$longNode = $longNode->{'ancestor'};
		$nearNode = $nearNode->{'ancestor'};
	}
	return $nearNode;
}

sub getHeight {
	my ($top, $node) = @_;
	my $height = 0;
	while ($node->{'ancestor'} != $top) {
		$node = $node->{'ancestor'};
		$height += 1;
	}
	return $height;
}

