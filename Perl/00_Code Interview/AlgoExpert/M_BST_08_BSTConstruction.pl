#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
BST Construction

Write a BST class for a Binary Search Tree. The class should support:
    - inserting values with the insert method. 
    - Removing values with the remove method; this method should only remove the first instance of a given value.
    - Searching for values with the contains method. 

Note that you can't remove values from a single-node tree. In other words, calling the 
remove method on a single-node tree should simply not do anything. 

Each BST node has an integer value. a left child node, and a right child node. 
A node is said to be a valid BST node if and only if it satisfies the BST property:
its value is strictly greater than the values of every node to its left; its value 
is less than or equal to the values of every node to its right; and its children nodes
are either valid BST nodes themselves or NONE/NULL

Sample Usage: //Assume the following BST has already been created:
     10
    /   \
   5     15
  / \   /  \
  2  5  13  22
 /       \
 1       14

insert(12):
    10
   /   \
  5     15
 / \    /  \
 2  5  13  22
/      / \
1     12 14

remove(10):
    12
   /   \
  5     15
 / \    /  \
 2  5  13  22
/       \
1       14

contains(15): True
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

sub insert {
	my ($self, $value)=@_;
	if ($self->{'value'} > $value) {
		if ($self->{'left'} eq NULL) {
			$self->{'left'} = BST->new($value);
		}
		else {
			$self->{'left'}->insert($value);
		}
	} else {
		if ($self->{'right'} eq NULL) {
			$self->{'right'} = BST->new($value);
		}
		else {
			$self->{'right'}->insert($value);
		}
	}
}

sub contain {
	my ($self, $value)=@_;
	if ($self->{'value'} > $value) {
		if ($self->{'left'} eq NULL) {
			return -1;
		}
		else {
			return $self->{'left'}->contain($value);
		}
	} elsif ($self->{'value'} < $value) {
		if ($self->{'right'} eq NULL) {
			return -1;
		}
		else {
			return $self->{'right'}->contain($value);
		}
	} else {
		return 1;
	}
}

sub remove {
	my ($self, $value, $parent)=@_;
	if ($self->{'value'} > $value) {
		if (!($self->{'left'} eq NULL)) {
			$self->{'left'}->remove($value, $self);
		}
	} elsif  ($self->{'value'} < $value) {
		if (!($self->{'right'} eq NULL)) {
			$self->{'right'}->remove($value, $self);
		}
	} else {
		if (!($self->{'left'} eq NULL) and !($self->{'right'} eq NULL)) {
			$self->{'value'} = $self->{'right'}->findMinValue();
			$self->{'right'}->remove($self->{'value'}, $self);
		} else {
			if (!defined($parent)) {
				if (!($self->{'left'} eq NULL)) {
					$self->{'value'} = $self->{'left'}->{'value'};
					$self->{'right'} = $self->{'left'}->{'right'};
					$self->{'left'} = $self->{'left'}->{'left'};
				} elsif (!($self->{'right'} eq NULL)) {
					$self->{'value'} = $self->{'right'}->{'value'};
					$self->{'left'} = $self->{'right'}->{'left'};
					$self->{'right'} = $self->{'right'}->{'right'};
				} else {
					next;
				}
			} elsif ($parent->{'left'} == $self) {
				$parent->{'left'} = ($self->{'left'} eq NULL) ? $self->{'right'} : $self->{'left'};
			} elsif ($parent->{'right'} == $self) {
				$parent->{'right'} = ($self->{'left'} eq NULL) ? $self->{'right'} : $self->{'left'};
			}
		}
	}
}

sub findMinValue {
	my ($self) = @_;
	if ($self->{'left'} eq NULL) {
		return $self->{'value'};
	} else {
		return $self->{'left'}->findMinValue();
	}
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

print(Dumper($root));
#$root->insert(12);
#print(Dumper($root));
$root->remove(10);
print(Dumper($root));
print($root->contain(1));
