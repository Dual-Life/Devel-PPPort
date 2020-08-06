#!/usr/bin/perl

use strict;
use warnings;

use FindBin;

exit( run(@ARGV) || 0 ) unless caller;

sub run {
    my $now = time();

    my $a_day = 86400;
    my $today = $now - $now % $a_day;

    my ( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) =
      localtime($today);
    ++$mon;
    $year += 1900;

    my $human_ts = sprintf( "%04d-%02d-%02d", $year, $mon, $mday );

    print qq[# Updating D_PPP_RELEASE_DATE timestamp to $today /* $human_ts */\n];

    my $f             = q[parts/inc/version];
    my $file_to_patch = $FindBin::Bin . '/../' . $f;
    die "Cannot find $f: $!" unless -e $file_to_patch;

    my $content;
    {
        local $/;
        open( my $fh, '<', $file_to_patch );
        $content = <$fh>;
    }

    $content =~
      s{^(\#\s*define\s+D_PPP_RELEASE_DATE)\b.*$}{$1 $today /* $human_ts */}m
      or die "Cannot find D_PPP_RELEASE_DATE pattern in file $f";

    {
        local $/;
        open( my $fh, '>', $file_to_patch );
        print {$fh} $content;
    }

    print qq[$f patched with D_PPP_RELEASE_DATE\n];

    return;
}

1;
