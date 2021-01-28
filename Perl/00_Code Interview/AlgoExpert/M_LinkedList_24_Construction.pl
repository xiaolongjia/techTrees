#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Linked List Construction

Write a DoublyLinkedList class that has a head and a tail. both of which point to 
either a linked list Node or None/Null. The class should support:

- Setting the head and tail of the linked list. 
- Inserting nodes before and after other nodes as well as at given positions (the position of the head node is 1)
- Removing given nodes and removing nodes with given values. 
- Searching for nodes with given values. 

Note that the setHead, setTail, insertBefore, insertAfter, insertAtPosition. 
and remove methods all take in actual Node as input parameters -- not integers (except 
for insertAtPosition, which also takes in an integer representing the position); this means 
that you do not need to create any new Node in these methods. 
The input nodes can be either stand-alone nodes or nodes that are already in the linked list.
if they are nodes that are already in the linked list, the methods will effectively be mobing 
the nodes within the linked list. you won't be told if the input nodes are already 
in the linked list. so your code will have defensively handle this scenario. 

Each Node has an integer value as well as a prev node and a next node, both of which 
can point to either another node or None/null.

Sample Usage: 1<->2 <->3 <-> 4 <-> 5
3, 3, 6, # stand-alone nodes
setHead(4): 4 <-> 1 <-> 2 <-> 3 <-> 5
setTail(6): 4 <-> 1 <-> 2 <-> 3 <-> 5 <->6
insertBefore(6,3):  4 <-> 1 <-> 2 <-> 5 <-> 3 <->6
insertAfter(6,3):  4 <-> 1 <-> 2 <-> 5 <-> 3  <-> 6 <-> 3 
insertAtPosition(1,3): 3<-> 4 <-> 1 <-> 2 <-> 5 <-> 3  <-> 6 <-> 3 
removeNodesWithValue(3): 4 <-> 1 <-> 2 <-> 5 <-> 6
remove(2): 4 <-> 1 <-> 5 <-> 6
containsNodeWithValue(5): true 
=cut

package Node ; 

sub new {
	my ($type, $value)=@_;
	my $self={};
	$self->{'value'} = $value;
	$self->{'prev'} = NULL;
	$self->{'next'} = NULL;
	bless $self,$type;
}

package DoublyLinkedList ;
use Node;

sub new {
	my ($type)=@_;
	my $self={};
	$self->{'head'} = NULL;
	$self->{'tail'} = NULL;
	bless $self,$type;
}

sub setHead {
	my ($type, $node)=@_;
	

}

package main;

my $node1 = Node->new(1);
my $node2 = Node->new(2);
my $node3 = Node->new(3);
my $node4 = Node->new(4);
my $node5 = Node->new(5);

my $dllist = DoublyLinkedList->new();
$dllist->setHead($node5);


