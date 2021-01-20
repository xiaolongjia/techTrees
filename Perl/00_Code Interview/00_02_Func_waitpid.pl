#!C:\user\local\Perl\bin\perl
##!C:\Strawberry\perl\bin\Perl

use Data::Dumper;
use IO::Handle;

$procid = fork();
if ($procid == 0) {
  # this is the child process
  print ("this line is printed first\n");
  exit(1);
} else {
  # this is the parent process
  waitpid ($procid, 1);
  print ("this line is printed last\n");
} 

