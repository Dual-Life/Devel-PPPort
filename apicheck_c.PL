$out = 'apicheck.c';
print "creating $out\n";
system $^X, 'parts/apicheck.pl', $out
    and die "couldn't create $out\n";
