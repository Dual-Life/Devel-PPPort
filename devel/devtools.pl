################################################################################
#
#  devtools.pl -- various utility functions
#
################################################################################
#
#  Version 3.x, Copyright (C) 2004-2013, Marcus Holland-Moritz.
#  Version 2.x, Copyright (C) 2001, Paul Marquess.
#  Version 1.x, Copyright (C) 1999, Kenneth Albanowski.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the same terms as Perl itself.
#
################################################################################

use IO::File;
require "./parts/inc/inctools";

eval "use Term::ANSIColor";
$@ and eval "sub colored { pop; @_ }";

my @argvcopy = @ARGV;

sub verbose
{
  if ($opt{verbose}) {
    my @out = @_;
    s/^(.*)/colored("($0) ", 'bold blue').colored($1, 'blue')/eg for @out;
    print STDERR @out;
  }
}

sub ddverbose
{
  return $opt{verbose} ? ('--verbose') : ();
}

sub runtool
{
  my $opt = ref $_[0] ? shift @_ : {};
  my($prog, @args) = @_;
  my $sysstr = join ' ', map { "'$_'" } $prog, @args;
  $sysstr .= " >$opt->{'out'}"  if exists $opt->{'out'};
  $sysstr .= " 2>$opt->{'err'}" if exists $opt->{'err'};
  verbose("running $sysstr\n");
  my $rv = system $sysstr;
  verbose("$prog => exit code $rv\n");
  return not $rv;
}

sub runperl
{
  my $opt = ref $_[0] ? shift @_ : {};
  runtool($opt, $^X, @_);
}

sub run
{
  my $prog = shift;
  my @args = @_;

  runtool({ 'out' => 'tmp.out', 'err' => 'tmp.err' }, $prog, @args);

  my $out = IO::File->new("tmp.out") or die "tmp.out: $!\n";
  my $err = IO::File->new("tmp.err") or die "tmp.err: $!\n";

  my %rval = (
    status    => $? >> 8,
    stdout    => [<$out>],
    stderr    => [<$err>],
    didnotrun => 0,
  );

  unlink "tmp.out", "tmp.err";

  $? & 128 and $rval{core}   = 1;
  $? & 127 and $rval{signal} = $? & 127;

  return \%rval;
}

sub ident_str
{
  return "$^X $0 @argvcopy";
}

sub identify
{
  verbose(ident_str() . "\n");
}

sub ask($)
{
  my $q = shift;
  my $a;
  local $| = 1;
  do {
    print "\a\n$q [y/n] ";
    $a = <>; }
  while ($a !~ /^\s*([yn])\s*$/i);
  return lc $1 eq 'y';
}

sub quit_now
{
  print "\nSorry, cannot continue.\n\n";
  exit 1;
}

sub ask_or_quit
{
  quit_now unless &ask;
}

sub eta
{
  my($start, $i, $n) = @_;
  return "--:--:--" if $i < 3;
  my $elapsed = tv_interval($start);
  my $h = int($elapsed*($n-$i)/$i);
  my $s = $h % 60; $h /= 60;
  my $m = $h % 60; $h /= 60;
  return sprintf "%02d:%02d:%02d", $h, $m, $s;
}

sub get_and_sort_perls($)
{
    my $opt = shift;

    # Get blead and all other perls
    my @perls = $opt->{blead};
    for my $dir (split ",", $opt->{install}) {
        push @perls, grep !/-RC\d+/, glob "$dir/bin/perl5.*";
    }

    # Normalize version numbers into 5.xxxyyy, and convert each element
    # describing the perl to be a hash with keys 'version' and 'path'
    for (my $i = 0; $i < @perls; $i++) {
        my $version = `$perls[$i] -e 'print \$]'`;
        my $file = int_parse_version($version);
        $version = format_version($version);

        # Make this entry a hash with its version, file name, and path
        $perls[$i] = { version =>  $version,
                       file    =>  $file,
                       path    =>  $perls[$i],
                     };
    }

    # Sort in descending order.  We start processing the most recent perl
    # first.
    @perls = sort { $b->{file} <=> $a->{file} } @perls;

    # Override blead's version if specified.
    if (exists $opt->{'blead-version'}) {
        $perls[0]{version} = format_version($opt->{'blead-version'});
    }

    my %seen;

    # blead's todo is its version plus 1.  Otherwise, each todo is the
    # previous one's.  Also get rid of duplicate versions.
    $perls[0]{todo} = $perls[0]{file} + 1;
    $seen{$perls[0]{file}} = 1;
    for my $i (1 .. $#perls) {
        last unless defined $perls[$i];
        if (    exists $seen{$perls[$i]{file}}) {
            splice @perls, $i, 1;
            redo;
        }

        $seen{$perls[$i]{file}} = 1;
        $perls[$i]{todo} = $perls[$i-1]{file};
    }

    return \@perls;
}

1;
