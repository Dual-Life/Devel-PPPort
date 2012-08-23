use strict;
$^W = 1;
require "parts/ppptools.pl";

my $INCLUDE = 'parts/inc';
my $DPPP = 'DPPP_';

my %embed = map { ( $_->{name} => $_ ) }
            parse_embed(qw(parts/embed.fnc parts/apidoc.fnc));

my(%provides, %prototypes);

my $data = do { local $/; <DATA> };
$data =~ s{^\%(include)\s+(\w+)((?:[^\S\r\n]+.*?)?)\s*$}
          {eval "$1('$2', $3)" or die $@}gem;

$data = expand($data);

my @api = sort { lc $a cmp lc $b } keys %provides;

$data =~ s{^([\t ]*)__PROVIDED_API__(\s*?)^}
          {join '', map "$1$_\n", @api}gem;

my %t = %{&parse_todo};

my %todo;
for (keys %t) {
  push @{$todo{$t{$_}}}, $_;
}

# check consistency
for (@api) {
  if (exists $t{$_}) {
    warn "$INCLUDE/$provides{$_} provides $_, which is still marked "
         . "todo for " . format_version($t{$_}) . "\n";
  }
}

my @perl_api;
for (keys %provides) {
  next if exists $embed{$_};
  push @perl_api, $_;
  check(2, "No API definition for provided element $_ found.");
}

push @perl_api, keys %embed;

for (@perl_api) {
  my $line = "$_|" . ($t{$_} || '') . '|';
  $line .= 'p' if exists $provides{$_};
  if (exists $embed{$_}) {
    my $e = $embed{$_};
    if (exists $e->{flags}{p}) {
      my $args = $e->{args};
      $line .= 'v' if @$args && $args->[-1][0] eq '...';
    }
    $line .= 'n' if exists $e->{flags}{n};
  }
  $_ = $line;
}

$data =~ s/^([\t ]*)__PERL_API__(\s*?)$/
           join "\n", map "$1$_", sort @perl_api
          /gem;

my @todo;
for (reverse sort keys %todo) {
  my $ver = format_version($_);
  my $todo = "=item perl $ver\n\n";
  for (sort @{$todo{$_}}) {
    $todo .= "  $_\n";
  }
  push @todo, $todo;
}

$data =~ s{^__UNSUPPORTED_API__(\s*?)^}
          {join "\n", @todo}gem;

$data =~ s{__MIN_PERL__}{5.003}g;
$data =~ s{__MAX_PERL__}{5.9.2}g;

open FH, ">PPPort.pm" or die "PPPort.pm: $!\n";
print FH $data;
close FH;

exit 0;

sub include
{
  my($file, $opt) = @_;

  print "including $file\n";

  my $data = parse_partspec("$INCLUDE/$file");

  for (@{$data->{provides}}) {
    if (exists $provides{$_}) {
      if ($provides{$_} ne $file) {
        warn "$file: $_ already provided by $provides{$_}\n";
      }
    }
    else {
      $provides{$_} = $file;
    }
  }

  for (keys %{$data->{prototypes}}) {
    $prototypes{$_} = $data->{prototypes}{$_};
    $data->{implementation} =~ s/^$_(?=\s*\()/$DPPP($_)/g;
  }

  my $out = $data->{implementation};

  if (exists $opt->{indent}) {
    $out =~ s/^/$opt->{indent}/gm;
  }

  return $out;
}

sub expand
{
  my $code = shift;
  $code =~ s{^(\s*#\s*(?:el)?if\s+)(.*)$}{$1.expand_pp_expressions($2)}gem;
  $code =~ s{^\s*
              __UNDEFINED__
              \s+
              (
                ( \w+ )
                (?: \( [^)]* \) )?
              )
              [^\r\n\S]*
              (
                (?:[^\r\n\\]|\\[^\r\n])*
                (?:
                  \\
                  (?:\r\n|[\r\n])
                  (?:[^\r\n\\]|\\[^\r\n])*
                )*
              )
            \s*$}
            {expand_undefined($2, $1, $3)}gemx;
  return $code;
}

sub expand_undefined
{
  my($macro, $withargs, $def) = @_;
  my $rv = "#ifndef $macro\n#  define ";

  if (defined $def) {
    $rv .= sprintf "%-30s %s", $withargs, $def;
  }
  else {
    $rv .= $withargs;
  }

  $rv .= "\n#endif\n";

  return $rv;
}

sub expand_pp_expressions
{
  my $pp = shift;
  $pp =~ s/\{([^\}]+)\}/expand_pp_expr($1)/ge;
  return $pp;
}

sub expand_pp_expr
{
  my $expr = shift;

  if ($expr =~ /^\s*version\s*(<|>|==|!=|>=|<=)\s*([\d._]+)\s*$/i) {
    my($op, $ver) = ($1, $2);
    my($r, $v, $s) = parse_version($ver);
    $r == 5 or die "only Perl revision 5 is supported\n";
    $op eq '=='     and return "((PERL_VERSION == $v) && (PERL_SUBVERSION == $s))";
    $op eq '!='     and return "((PERL_VERSION != $v) || (PERL_SUBVERSION != $s))";
    $op =~ /([<>])/ and return "((PERL_VERSION $1 $v) || ((PERL_VERSION == $v) && (PERL_SUBVERSION $op $s)))";
  }

  if ($expr =~ /^\s*need\s*(\w+)\s*$/i) {
    my $func = $1;
    my $e = $embed{$func} or die "unknown API function '$func' in NEED\n";
    my $proto = make_prototype($e);
    if (exists $prototypes{$func}) {
      if (compare_prototypes($proto, $prototypes{$func})) {
        check(1, "differing prototypes for $func:\n  API: $proto\n  PPP: $prototypes{$func}");
        $proto = $prototypes{$func};
      }
    }
    else {
      warn "found no prototype for $func\n";;
    }

    $proto =~ s/\b$func(?=\s*\()/$DPPP($func)/;
    my $embed = make_embed($e);

    return "defined(NEED_$func)\n"
         . "static $proto;\n"
         . "static\n"
         . "#else\n"
         . "extern $proto;\n"
         . "#endif\n"
         . "\n"
         . "$embed\n"
         . "\n"
         . "#if defined(NEED_$func) || defined(NEED_${func}_GLOBAL)"
  }


  die "cannot expand preprocessor expression '$expr'\n";
}

sub make_embed
{
  my $f = shift;
  my $n = $f->{name};
  my $a = do { my $x = 'a'; join ',', map { $x++ } 1 .. @{$f->{args}} };

  if ($f->{flags}{n}) {
    if ($f->{flags}{p}) {
      return "#define $n $DPPP($n)\n" .
             "#define Perl_$n $DPPP($n)";
    }
    else {
      return "#define $n $DPPP($n)";
    }
  }
  else {
    my $undef = <<UNDEF;
#ifdef $n
#  undef $n
#endif
UNDEF
    if ($f->{flags}{p}) {
      return $undef . "#define $n($a) $DPPP($n)(aTHX_ $a)\n" .
                      "#define Perl_$n $DPPP($n)";
    }
    else {
      return $undef . "#define $n($a) $DPPP($n)(aTHX_ $a)";
    }
  }
}

sub check
{
  my $level = shift;

  if (exists $ENV{PPP_CHECK_LEVEL} and $ENV{PPP_CHECK_LEVEL} >= $level) {
    print STDERR @_, "\n";
  }
}

__DATA__
################################################################################
#
#  !!!!! Do NOT edit this file directly! -- Edit PPPort_pm.PL instead. !!!!!
#
################################################################################
#
#  Perl/Pollution/Portability
#
################################################################################
#
#  Version 3.x, Copyright (C) 2003, Marcus Holland-Moritz.
#  Version 2.x, Copyright (C) 2001, Paul Marquess.
#  Version 1.x, Copyright (C) 1999, Kenneth Albanowski.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the same terms as Perl itself.
#
################################################################################

=head1 NAME

Devel::PPPort - Perl/Pollution/Portability

=head1 SYNOPSIS

    Devel::PPPort::WriteFile() ; # defaults to ./ppport.h
    Devel::PPPort::WriteFile('someheader.h') ;

=head1 DESCRIPTION

Perl has changed over time, gaining new features, new functions,
increasing its flexibility, and reducing the impact on the C namespace
environment (reduced pollution). The header file, typicaly C<ppport.h>,
written by this module attempts to bring some of the newer Perl
features to older versions of Perl, so that you can worry less about
keeping track of old releases, but users can still reap the benefit.
 
Why you should use C<ppport.h> in modern code: so that your code will work
with the widest range of Perl interpreters possible, without significant
additional work.

Why you should attempt older code to fully use C<ppport.h>: because
the reduced pollution of newer Perl versions is an important thing, so
important that the old polluting ways of original Perl modules will not be
supported very far into the future, and your module will almost certainly
break! By adapting to it now, you'll gain compatibility and a sense of
having done the electronic ecology some good.

How to use ppport.h: Don't direct the user to download C<Devel::PPPort>,
and don't make C<ppport.h> optional. Rather, just take the most recent
copy of C<ppport.h> that you can find (probably in C<Devel::PPPort>
on CPAN), copy it into your project, adjust your project to use it,
and distribute the header along with your module.

C<Devel::PPPort> contains a single function, called C<WriteFile>. It's
purpose is to write a 'C' header file that is used when writing XS
modules. The file contains a series of macros that allow XS modules to
be built using older versions of Perl.

Not only macros, but also static/global functions, if requested.             !!!TODO!!!

This module is used by h2xs to write the file F<ppport.h>. 

=head2 WriteFile

C<WriteFile> takes a zero or one parameters. When called with one
parameter it expects to be passed a filename. When called with no
parameters, it defaults to the filename C<./pport.h>.

The function returns TRUE if the file was written successfully. Otherwise
it returns FALSE.

=head1 ppport.h

=head2 Provided Perl compatibility API

The file written by this module, typically C<ppport.h>, provides access
to the following Perl API if not already available (and in some cases [*]     !!!TODO!!!
even if available, access to a fixed interface):

    __PROVIDED_API__

=head2 Perl API not supported by ppport.h

There is still a big part of the API not supported by ppport.h. Either
because it doesn't make sense to backport that part of the API, or
simply because it hasn't been implemented yet. Patches welcome!

Here's a list of the currently unsupported API, and also which version
of Perl introduced it:

=over 4

__UNSUPPORTED_API__

=back

=head1 AUTHOR

Version 1.x of Devel::PPPort was written by Kenneth Albanowski.

Version 2.x was ported to the Perl core by Paul Marquess.

Version 3.x was ported back to CPAN by Marcus Holland-Moritz.

=head1 SEE ALSO

See L<h2xs>.

=cut

package Devel::PPPort;

require DynaLoader;
use strict;
use vars qw($VERSION @ISA $data);

$VERSION = "2.99_01";

@ISA = qw(DynaLoader);

bootstrap Devel::PPPort;

{
  $data = do { local $/; <DATA> };
  my $now = localtime;
  my $pkg = 'Devel::PPPort';
  $data =~ s/__PERL_VERSION__/$]/g;
  $data =~ s/__VERSION__/$VERSION/g;
  $data =~ s/__DATE__/$now/g;
  $data =~ s/__PKG__/$pkg/g;
  $data =~ s/^POD\s//gm;
}

sub WriteFile
{
  my $file = shift || 'ppport.h';

  open F, ">$file" or return undef;
  print F $data;
  close F;

  return 1;
}

1;

__DATA__
#if 0
<<'SKIP';
#endif
/*
----------------------------------------------------------------------

    ppport.h -- Perl/Pollution/Portability Version __VERSION__ 
   
    Automatically created by __PKG__ running under
    perl __PERL_VERSION__ on __DATE__.
    
    Do NOT edit this file directly! -- Edit PPPort_pm.PL and the
    includes in parts/inc/ instead.
 
    Use 'perldoc ppport.h' to view the documentation below.

----------------------------------------------------------------------

SKIP

%include pod { indent => 'POD ' }

%include pppcheck

__DATA__
*/

#ifndef _P_P_PORTABILITY_H_
#define _P_P_PORTABILITY_H_

#ifndef DPPP_FUNCTION_PREFIX
#  define DPPP_FUNCTION_PREFIX DPPP_
#endif

#define DPPP_CAT2(x,y) CAT2(x,y)
#define DPPP_(name) DPPP_CAT2(DPPP_FUNCTION_PREFIX, name)

%include version

%include limits

%include uv

%include misc

%include threads

%include mPUSH

%include eval_pv

%include newRV

%include newCONSTSUB

%include MY_CXT

%include format

%include SvPV

%include magic

%include cop

%include grok

#endif /* _P_P_PORTABILITY_H_ */

/* End of File ppport.h */
