#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Remove Kth Node From End

Write a function that takes in the head of a Singly Linked List and an integer k 
and removes the kth node from the end of the list. 

The removal should be done in place, meaning that the original data structure should 
be mutated (no new structure should be created)

Furthermore, the input head of the linked list should remain the head of the linked list 
after the removal is done, even if the head is the node that's supposed to be removed.
In other words, if the head is the node that's supposed to be removed, your function 
should simply mutate its value and next pointer. 

Note that your function doesn't need to return anything. 

You can assume that the input Linked List will always have at least two nodes and,
more specifically, at least k nodes. 

Each Linked List node has an integer value as well as a next node pointing to the next node
in the list or to None / null if its the tail of the list. 

Sample Input:
head = 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9
k = 4

Sample Output:
head = 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 7 -> 8 -> 9
=cut

package LinkedList ;

sub new {
	my ($type, $value)=@_;
	my $self={};
	$self->{'value'} = $value;
	$self->{'next'} = NULL;
	bless $self,$type;
}

sub llistPrint {
	my ($type, $head) = @_;
	my @values = ($head->{'value'});
	my $nextNode = $head->{'next'};
	while (!($nextNode eq NULL)) {
		push @values, $nextNode->{'value'};
		$nextNode = $nextNode->{'next'};
	}
	return join("->", @values);
}

package main;

my $node0 = LinkedList->new(0);
my $node1 = LinkedList->new(1);
my $node2 = LinkedList->new(2);
my $node3 = LinkedList->new(3);
my $node4 = LinkedList->new(4);
my $node5 = LinkedList->new(5);
my $node6 = LinkedList->new(6);
my $node7 = LinkedList->new(7);
my $node8 = LinkedList->new(8);
my $node9 = LinkedList->new(9);
$node0->{'next'} = $node1;
$node1->{'next'} = $node2;
$node2->{'next'} = $node3;
$node3->{'next'} = $node4;
$node4->{'next'} = $node5;
$node5->{'next'} = $node6;
$node6->{'next'} = $node7;
$node7->{'next'} = $node8;
$node8->{'next'} = $node9;
print(Dumper($node0->llistPrint($node0)));
my $newHead = &removeKthNodeFromEnd($node0, 9);
print(Dumper($newHead->llistPrint($newHead)));

sub removeKthNodeFromEnd {
	my ($head, $k) = @_;
	
	my $first = $head;
	my $second = $head;
	my $counter = 1;
	while ($counter <= $k) {
		$second = $second->{'next'};
		$counter += 1;
	}
	if ($second eq NULL) {
		$head->{'value'} = $head->{'next'}->{'value'};
		$head->{'next'} = $head->{'next'}->{'next'};
		return $head;
	}
	while (!($second->{'next'} eq NULL)) {
		$second = $second->{'next'};
		$first = $first->{'next'};
	}
	$first->{'next'} = $first->{'next'}->{'next'};
	return $head;
}

