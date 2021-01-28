#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Min Heap Construction

Implement a Minheap class that supports:

- Building a Min Heap from an input array of integers
- Interting integers in the heap 
- Removing the heap's minimum / root value 
- Peeking at the heap's minimum / root value 
- Sifting integers up and down the heap, which is to be used when inserting and removing values 

Note that the heap should be represented in the form of an array. 

Sample Usage:
array = [48,12, 24, 7, 8, -5, 24, 391, 24, 56, 2, 6, 8, 41]

MinHeap(array)
buildHeap(array): [-5,2,6,7,8,8,24,391,24,56,12,24,48,41]
insert(76):  [-5,2,6,7,8,8,24,391,24,56,12,24,48,41,76]
peek():-5
remove(): -5 [2,7,6, 24, 8,8,24,391,76,56,12,24,48,41]
peek(): 2
remove():2 [6,7,8,24,8, 24, 24, 391,76,56,12,41,48]
peek(): 6
insert(87): 
=cut

package MinHeap ;
use Data::Dumper;

sub new {
	my ($type, $array)=@_;
	my $self={};
	$self->{'heap'} = $array;
	bless $self,$type;
}

sub buildMinHeap {
	my ($self)=@_;
	my $array = $self->{'heap'};
	my $length = scalar @$array;
	my $endIndex = $length - 1;
	my $lastParent = int(($length - 2)/2);
	while ($lastParent >= 0) {
		$self->siftDown($lastParent, $endIndex);
		$lastParent -= 1;
	}
}

sub siftDown {
	my ($self, $currIdx, $endIndex) = @_ ;
	my $array = $self->{'heap'};
	my $leftChild = 2*$currIdx + 1;
	while($leftChild <= $endIndex) {
		my $idx2swap = $leftChild;
		my $rightChild = $leftChild + 1;
		
		if (!($rightChild >  $endIndex) and ($array->[$rightChild] < $array->[$leftChild])) {
			$idx2swap = $rightChild ;
		}
		#print("parent: $currIdx \t left: $leftChild \t right: $rightChild \t swap: $idx2swap \n"); 
		#print("parentValue: ".$array->[$currIdx]." swapValue: ". $array->[$idx2swap]."\n");sleep(2);
		if ($array->[$currIdx] > $array->[$idx2swap]) {
			#print("swaping: $currIdx <-> $idx2swap \n");
			($array->[$currIdx], $array->[$idx2swap]) = ($array->[$idx2swap], $array->[$currIdx]);
		}
		$currIdx = $idx2swap;
		$leftChild = 2*$currIdx + 1;
	}
	$self->{'heap'} =  $array;
}

sub insert {
	my ($self, $value) = @_;
	push @{$self->{'heap'}}, $value;
	my $currIdx = scalar @{$self->{'heap'}} -1;
	$self->siftUp($currIdx);
}

sub siftUp {
	my ($self, $currIdx) = @_;
	my $array = $self->{'heap'};
	my $parentIdx = int(($currIdx-1)/2);
	while($parentIdx >=0) {
		if ($array->[$parentIdx] > $array->[$currIdx]) {
			($array->[$currIdx], $array->[$parentIdx]) = ($array->[$parentIdx], $array->[$currIdx]);
			$currIdx = $parentIdx;
			$parentIdx = int(($currIdx-1)/2);
		} else {
			last;
		}
	}
	$self->{'heap'} =  $array;
}

sub peek {
	my $self = shift;
	return @{$self->{'heap'}}[0];
}

sub remove {
	my $self = shift;
	my $value = shift;
	my $array = $self->{'heap'};
	my $endIdx = scalar @$array - 1;
	($array->[$value], $array->[$endIdx]) = ($array->[$endIdx], $array->[$value]);
	pop @$array;
	$self->{'heap'} = $array;
	$self->siftDown($value, $endIdx-1);
}


package main;

my @array = (48,12, 24, 7, 8, -5, 24, 391, 24, 56, 2, 6, 8, 41);
my $minHeap = MinHeap->new(\@array);
$minHeap->buildMinHeap();
print(Dumper($minHeap->{'heap'}));
$minHeap->insert(76);
print(Dumper($minHeap->{'heap'}));
print(Dumper($minHeap->peek()));
$minHeap->remove(0);
print(Dumper($minHeap->{'heap'}));
print(Dumper($minHeap->peek()));
$minHeap->remove(0);
print(Dumper($minHeap->{'heap'}));
$minHeap->insert(87);
print(Dumper($minHeap->{'heap'}));
$minHeap->remove(3);
print(Dumper($minHeap->{'heap'}));