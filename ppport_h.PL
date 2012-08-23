package Devel::PPPort; 
sub bootstrap {}; 
require "PPPort.pm";
rename 'ppport.h', 'ppport.old' if -f 'ppport.h';
unlink "ppport.old" if WriteFile("ppport.h") && -f 'ppport.h';
