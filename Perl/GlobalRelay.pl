#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;
use List::Util qw/max min/;

=begin:
There is a queue of N cars waiting at a filling station. there are three fuel dispensers at the station, labeled X, Y and Z, 
respectively. Each dispenser has some finite amount of fuel in it; at all times the amount of available fuel is clearly displayed on each dispenser.

When a car arrives at the front of the queue, the driver can choose to drive to any dispenser not occupied by another car. Suppose that the fuel demand is D liters
for this car. The driver must choose a dispenser which has at least D liters of fuelel. If all unoccupied dispensers have less than D liters, the driver 
must wait for some other car to finish tanking up. If all dispensers are unoccupied, and nono has at least D liters, the driver is unable to refuel the car 
and it blocks the queue indefinitely. If more than one unoccupied dispenser has at least D liters, the driver chooses the one labeled with the smallest letter 
among them.

Each driver will have to wait some amount of time before he or she starts refueling the car. Calculate the maximum waiting time among all drivers. Assume that tanking 
one liter of fuel takes exactly one second, and moving cars is instantaneous. 

Write a function:

That, given an array A consisting of N integers (which specify the fuel demandmands in liters for subsequent cars in the queue), and numbers X, Y and Z (which specify 
the initial amount of fuel in the respective dispensers), returns the maximum waiting time for a car . if any car is unable to refuel, the function should return -1.

For example, given X=7, Y=11, Z=3 and the following array A is:
A[0] = 2
A[1] = 8
A[2] = 4
A[3] = 3
A[4] = 2

the function should return 8. The subsequent cars will have to wait in the queue for 0, 0, 2, 2 and 8 seconds, respectively. The scenario is as follows:
At time 0, car 0 drives to dispenser X.
At time 0, car 1 drives to dispenser Y.
There is no enough fuel in dispenser Z to satisfy the demands of car 2, so this car must wait. At time 2, car 0 finishes refueling and car 2 drives to dispenser X.
At time 2 car 3 drives to dispenser Z. 
At this time all dispensers are occupied, so car 4 waits. There will be not enough fuel in dispensers X and Z after car 2 and car 3 finish tanking up, so 
car 4 waits until car 1 finishes refuelling ar dispenser Y. At time 8, car 4 drives to dispenser Y.

For X=4, Y=0, Z=3 and array A:
A[0] = 5

the function should return -1.

=cut

my @A = (2, 8, 4, 3, 2);
my $X = 7;
my $Y = 11;
my $Z = 3;
#my @A = (4, 5, 6, 3, 2, 4, 7, 2, 2, 1, 4);
#my $X = 9;
#my $Y = 31;
#my $Z = 15;
print(&solution(\@A, $X, $Y, $Z));

sub solution {
    my ($A, $X, $Y, $Z)=@_; 
    my @A=@$A;
    # write your code in Perl 5.18
    my @dispensers = ($X, $Y, $Z);
    my @used = (0, 0, 0);
    
    for (my $i=0; $i<@A; $i++) {
        my $minIndex = 999999;
        my $minUsed  = 999999; 
        for (my $j=0; $j<@dispensers; $j++) {
		if ($dispensers[$j] >= $A[$i]) {
                	if (($used[$j]<$minUsed)) {
				$minIndex = $j;
				$minUsed = $used[$j];
			}
		}
        }
	if ($minIndex == 999999) {
		return -1;
	}
	if ($i == scalar @A - 1) {

		return max(@used);
	}
	else {
		$dispensers[$minIndex] -= $A[$i];
		$used[$minIndex] += $A[$i];
	}
    }
}

