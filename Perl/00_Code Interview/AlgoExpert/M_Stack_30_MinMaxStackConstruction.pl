#!C:\user\local\Perl\bin\perl

use Data::Dumper;

=begin
Min Max Stack Construction

Write a MinMaxStack class for a Min Max Stack. The class should support:
- pushing and popping values on and off the stack 
- peeking at the value at the top of the stack 
- Getting both the minimum and the maximum values in the stack at any given point in time 

All class methods, when considered independently, should run in constant time and with constant space. 
=cut

package MinMaxStack ;

sub new {
	my ($type)=@_;
	my $self={};
	$self->{'Stack'} = [];
	$self->{'MinMaxStack'} = [];
	bless $self,$type;
}

sub push {
	my ($self, $value)=@_;
	my $newMinMaxStack = {'min'=>$value, 'max'=>$value};
	if (scalar @{$self->{'MinMaxStack'}}) {
		my @temp = @{$self->{'MinMaxStack'}};
		my $lastMinMaxStack = $temp[$#temp];
		if ($lastMinMaxStack->{'min'} < $value) {
			$newMinMaxStack->{'min'} = $lastMinMaxStack->{'min'};
		}
		if ($lastMinMaxStack->{'max'} > $value) {
			$newMinMaxStack->{'max'} = $lastMinMaxStack->{'max'};
		}
	}
	push @{$self->{'MinMaxStack'}}, $newMinMaxStack;
	push @{$self->{'Stack'}}, $value ;
}

sub pop {
	my ($self)=@_;
	pop @{$self->{'MinMaxStack'}};
	my $data = pop @{$self->{'Stack'}};
	return $data;
}

sub peek {
	my ($self)=@_;
	my @temp = @{$self->{'Stack'}};
	return $temp[$#temp];
}

sub getMin {
	my ($self)=@_;
	my @temp = @{$self->{'MinMaxStack'}};
	my $lastMinMaxStack = $temp[$#temp];
	return $lastMinMaxStack->{'min'};
}

sub getMax {
	my ($self)=@_;
	my @temp = @{$self->{'MinMaxStack'}};
	my $lastMinMaxStack = $temp[$#temp];
	return $lastMinMaxStack->{'max'};
}

package main;

my $MinMaxStackObj = MinMaxStack->new();
$MinMaxStackObj->push(10);
$MinMaxStackObj->push(8);
$MinMaxStackObj->push(17);
$MinMaxStackObj->push(2);
print(Dumper($MinMaxStackObj->{'Stack'}));
print(Dumper($MinMaxStackObj->{'MinMaxStack'}));
print($MinMaxStackObj->pop());
print(Dumper($MinMaxStackObj->{'Stack'}));
print(Dumper($MinMaxStackObj->{'MinMaxStack'}));
print($MinMaxStackObj->peek());
print($MinMaxStackObj->getMin());
print($MinMaxStackObj->getMax());


