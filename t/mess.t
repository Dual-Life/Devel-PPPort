################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/mess instead.
#
#  This file was automatically generated from the definition files in the
#  parts/inc/ subdirectory by mktests.PL. To learn more about how all this
#  works, please read the F<HACKERS> file that came with this distribution.
#
################################################################################

use FindBin ();

BEGIN {
  if ($ENV{'PERL_CORE'}) {
    chdir 't' if -d 't';
    unshift @INC, '../lib' if -d '../lib' && -d '../ext';
    require Config; import Config;
    use vars '%Config';
    if (" $Config{'extensions'} " !~ m[ Devel/PPPort ]) {
      print "1..0 # Skip -- Perl configured without Devel::PPPort module\n";
      exit 0;
    }
  }

  use lib "$FindBin::Bin";
  use lib "$FindBin::Bin/../parts/inc";

  die qq[Cannot find "$FindBin::Bin/../parts/inc"] unless -d "$FindBin::Bin/../parts/inc";

  sub load {
    eval "use Test";
    require 'testutil.pl' if $@;
    require 'inctools';
  }

  if (102) {
    load();
    plan(tests => 102);
  }
}

use Devel::PPPort;
use strict;
BEGIN { $^W = 1; }

package Devel::PPPort;
use vars '@ISA';
require DynaLoader;
@ISA = qw(DynaLoader);
bootstrap Devel::PPPort;

package main;

BEGIN { if ("$]" < '5.006') { $^W = 0; } }

my $warn;
my $die;
local $SIG{__WARN__} = sub { $warn = $_[0] };
local $SIG{__DIE__} = sub { $die = $_[0] };

my $scalar_ref = \do {my $tmp = 10};
my $array_ref = [];
my $hash_ref = {};
my $obj = bless {}, 'Package';

undef $die;
ok !defined eval { Devel::PPPort::croak_sv("\xE1\n") };
ok $@, "\xE1\n";
ok $die, "\xE1\n";

undef $die;
ok !defined eval { Devel::PPPort::croak_sv(10) };
ok $@ =~ /^10 at \Q$0\E line /;
ok $die =~ /^10 at \Q$0\E line /;

undef $die;
$@ = 'should not be visible (1)';
ok !defined eval {
    $@ = 'should not be visible (2)';
    Devel::PPPort::croak_sv('');
};
ok $@ =~ /^ at \Q$0\E line /;
ok $die =~ /^ at \Q$0\E line /;

undef $die;
$@ = 'should not be visible';
ok !defined eval {
    $@ = 'this must be visible';
    Devel::PPPort::croak_sv($@)
};
ok $@ =~ /^this must be visible at \Q$0\E line /;
ok $die =~ /^this must be visible at \Q$0\E line /;

undef $die;
$@ = 'should not be visible';
ok !defined eval {
    $@ = "this must be visible\n";
    Devel::PPPort::croak_sv($@)
};
ok $@, "this must be visible\n";
ok $die, "this must be visible\n";

undef $die;
$@ = 'should not be visible';
ok !defined eval {
    $@ = 'this must be visible';
    Devel::PPPort::croak_sv_errsv()
};
ok $@ =~ /^this must be visible at \Q$0\E line /;
ok $die =~ /^this must be visible at \Q$0\E line /;

undef $die;
$@ = 'should not be visible';
ok !defined eval {
    $@ = "this must be visible\n";
    Devel::PPPort::croak_sv_errsv()
};
ok $@, "this must be visible\n";
ok $die, "this must be visible\n";

undef $die;
ok !defined eval { Devel::PPPort::croak_sv_with_counter("message\n") };
ok $@, "message\n";
ok Devel::PPPort::get_counter(), 1;

undef $die;
ok !defined eval { Devel::PPPort::croak_sv('') };
ok $@ =~ /^ at \Q$0\E line /;
ok $die =~ /^ at \Q$0\E line /;

undef $die;
ok !defined eval { Devel::PPPort::croak_sv("\xE1") };
ok $@ =~ /^\xE1 at \Q$0\E line /;
ok $die =~ /^\xE1 at \Q$0\E line /;

undef $die;
ok !defined eval { Devel::PPPort::croak_sv("\xC3\xA1") };
ok $@ =~ /^\xC3\xA1 at \Q$0\E line /;
ok $die =~ /^\xC3\xA1 at \Q$0\E line /;

undef $warn;
Devel::PPPort::warn_sv("\xE1\n");
ok $warn, "\xE1\n";

undef $warn;
Devel::PPPort::warn_sv(10);
ok $warn =~ /^10 at \Q$0\E line /;

undef $warn;
Devel::PPPort::warn_sv('');
ok $warn =~ /^ at \Q$0\E line /;

undef $warn;
Devel::PPPort::warn_sv("\xE1");
ok $warn =~ /^\xE1 at \Q$0\E line /;

undef $warn;
Devel::PPPort::warn_sv("\xC3\xA1");
ok $warn =~ /^\xC3\xA1 at \Q$0\E line /;

ok Devel::PPPort::mess_sv("\xE1\n", 0), "\xE1\n";
ok Devel::PPPort::mess_sv(do {my $tmp = "\xE1\n"}, 1), "\xE1\n";

ok Devel::PPPort::mess_sv(10, 0) =~ /^10 at \Q$0\E line /;
ok Devel::PPPort::mess_sv(do {my $tmp = 10}, 1) =~ /^10 at \Q$0\E line /;

ok Devel::PPPort::mess_sv('', 0) =~ /^ at \Q$0\E line /;
ok Devel::PPPort::mess_sv(do {my $tmp = ''}, 1) =~ /^ at \Q$0\E line /;

ok Devel::PPPort::mess_sv("\xE1", 0) =~ /^\xE1 at \Q$0\E line /;
ok Devel::PPPort::mess_sv(do {my $tmp = "\xE1"}, 1) =~ /^\xE1 at \Q$0\E line /;

ok Devel::PPPort::mess_sv("\xC3\xA1", 0) =~ /^\xC3\xA1 at \Q$0\E line /;
ok Devel::PPPort::mess_sv(do {my $tmp = "\xC3\xA1"}, 1) =~ /^\xC3\xA1 at \Q$0\E line /;

if ("$]" >= '5.006') {
    BEGIN { if ("$]" >= '5.006' && "$]" < '5.008') { require utf8; utf8->import(); } }

    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv("\x{100}\n") };
    if ("$]" < '5.007001' || "$]" > '5.007003') {
        ok $@, "\x{100}\n";
    } else {
        skip 'skip: broken utf8 support in die hook', 0;
    }
    if ("$]" < '5.007001' || "$]" > '5.008') {
        ok $die, "\x{100}\n";
    } else {
        skip 'skip: broken utf8 support in die hook', 0;
    }

    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv("\x{100}") };
    if ("$]" < '5.007001' || "$]" > '5.007003') {
        ok $@ =~ /^\x{100} at \Q$0\E line /;
    } else {
        skip 'skip: broken utf8 support in die hook', 0;
    }
    if ("$]" < '5.007001' || "$]" > '5.008') {
        ok $die =~ /^\x{100} at \Q$0\E line /;
    } else {
        skip 'skip: broken utf8 support in die hook', 0;
    }

    if ("$]" < '5.007001' || "$]" > '5.008') {
        undef $warn;
        Devel::PPPort::warn_sv("\x{100}\n");
        ok $warn, "\x{100}\n";

        undef $warn;
        Devel::PPPort::warn_sv("\x{100}");
        ok (my $tmp = $warn) =~ /^\x{100} at \Q$0\E line /;
    } else {
        for (1..2) {
            skip 'skip: broken utf8 support in warn hook', 0;
        }
    }

    ok Devel::PPPort::mess_sv("\x{100}\n", 0), "\x{100}\n";
    ok Devel::PPPort::mess_sv(do {my $tmp = "\x{100}\n"}, 1), "\x{100}\n";

    ok Devel::PPPort::mess_sv("\x{100}", 0) =~ /^\x{100} at \Q$0\E line /;
    ok Devel::PPPort::mess_sv(do {my $tmp = "\x{100}"}, 1) =~ /^\x{100} at \Q$0\E line /;
} else {
    for (1..12) {
        skip 'skip: no utf8 support', 0;
    }
}

if (ord('A') != 65) {
    for (1..24) {
        skip 'skip: no ASCII support', 0;
    }
} elsif (      "$]" >= '5.008'
         &&    "$]" != '5.013000'     # Broken in these ranges
         && ! ("$]" >= '5.011005' && "$]" <= '5.012000'))
{
    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv(eval '"\N{U+E1}\n"') };
    ok $@, "\xE1\n";
    ok $die, "\xE1\n";

    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv(eval '"\N{U+E1}"') };
    ok $@ =~ /^\xE1 at \Q$0\E line /;
    ok $die =~ /^\xE1 at \Q$0\E line /;

    {
        undef $die;
        my $expect = eval '"\N{U+C3}\N{U+A1}\n"';
        ok !defined eval { Devel::PPPort::croak_sv("\xC3\xA1\n") };
        ok $@, $expect;
        ok $die, $expect;
    }

    {
        undef $die;
        my $expect = eval 'qr/^\N{U+C3}\N{U+A1} at \Q$0\E line /';
        ok !defined eval { Devel::PPPort::croak_sv("\xC3\xA1") };
        ok $@ =~ $expect;
        ok $die =~ $expect;
    }

    undef $warn;
    Devel::PPPort::warn_sv(eval '"\N{U+E1}\n"');
    ok $warn, "\xE1\n";

    undef $warn;
    Devel::PPPort::warn_sv(eval '"\N{U+E1}"');
    ok $warn =~ /^\xE1 at \Q$0\E line /;

    undef $warn;
    Devel::PPPort::warn_sv("\xC3\xA1\n");
    ok $warn, eval '"\N{U+C3}\N{U+A1}\n"';

    undef $warn;
    Devel::PPPort::warn_sv("\xC3\xA1");
    ok $warn =~ eval 'qr/^\N{U+C3}\N{U+A1} at \Q$0\E line /';

    if ("$]" < '5.004') {
        for (1..8) {
            skip 'skip: no support for mess_sv', 0;
        }
    }
    else {
      ok Devel::PPPort::mess_sv(eval('"\N{U+E1}\n"'), 0), eval '"\N{U+E1}\n"';
      ok Devel::PPPort::mess_sv(do {my $tmp = eval '"\N{U+E1}\n"'}, 1), eval '"\N{U+E1}\n"';

      ok Devel::PPPort::mess_sv(eval('"\N{U+E1}"'), 0) =~ eval 'qr/^\N{U+E1} at \Q$0\E line /';
      ok Devel::PPPort::mess_sv(do {my $tmp = eval '"\N{U+E1}"'}, 1) =~ eval 'qr/^\N{U+E1} at \Q$0\E line /';

      ok Devel::PPPort::mess_sv("\xC3\xA1\n", 0), eval '"\N{U+C3}\N{U+A1}\n"';
      ok Devel::PPPort::mess_sv(do {my $tmp = "\xC3\xA1\n"}, 1), eval '"\N{U+C3}\N{U+A1}\n"';

      ok Devel::PPPort::mess_sv("\xC3\xA1", 0) =~ eval 'qr/^\N{U+C3}\N{U+A1} at \Q$0\E line /';
      ok Devel::PPPort::mess_sv(do {my $tmp = "\xC3\xA1"}, 1) =~ eval 'qr/^\N{U+C3}\N{U+A1} at \Q$0\E line /';
    }
} else {
    for (1..24) {
        skip 'skip: no support for \N{U+..} syntax', 0;
    }
}

if ("$]" >= '5.007003' or ("$]" >= '5.006001' and "$]" < '5.007')) {
    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv($scalar_ref) };
    ok $@ == $scalar_ref;
    ok $die == $scalar_ref;

    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv($array_ref) };
    ok $@ == $array_ref;
    ok $die == $array_ref;

    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv($hash_ref) };
    ok $@ == $hash_ref;
    ok $die == $hash_ref;

    undef $die;
    ok !defined eval { Devel::PPPort::croak_sv($obj) };
    ok $@ == $obj;
    ok $die == $obj;
} else {
    for (1..12) {
        skip 'skip: no support for exceptions', 0;
    }
}

ok !defined eval { Devel::PPPort::croak_no_modify() };
ok $@ =~ /^Modification of a read-only value attempted at \Q$0\E line /;

ok !defined eval { Devel::PPPort::croak_memory_wrap() };
ok $@ =~ /^panic: memory wrap at \Q$0\E line /;

ok !defined eval { Devel::PPPort::croak_xs_usage("params") };
ok $@ =~ /^Usage: Devel::PPPort::croak_xs_usage\(params\) at \Q$0\E line /;

