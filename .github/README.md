Devel-PPPort
============

[![](https://github.com/Dual-Life/Devel-PPPort/workflows/linux/badge.svg)](https://github.com/Dual-Life/Devel-PPPort/actions) [![](https://github.com/Dual-Life/Devel-PPPort/workflows/macos/badge.svg)](https://github.com/Dual-Life/Devel-PPPort/actions) [![](https://github.com/Dual-Life/Devel-PPPort/workflows/windows/badge.svg)](https://github.com/Dual-Life/Devel-PPPort/actions)

# NAME

Devel::PPPort internals for hackers

# SYNOPSIS

So you probably want to hack `Devel::PPPort`?

Well, here's some information to get you started with what's
lying around in this distribution.

# DESCRIPTION

## How to backport something

First, make sure that what you want to backport is documented.  If it's worth
backporting, it surely is worth documenting.  Submit a documentation patch to
[https://github.com/Perl/perl5/issues](https://github.com/Perl/perl5/issues) if necessary.  Also, `Devel::PPPort`
cannot automatically generate proper information about the item without at
least knowing its API prototype.  It can get this from `embed.fnc` if the item
is a function, but if it is a macro, there needs to be at least a `=for apidoc` line for `Devel::PPPort` to be able to figure things out on its own.

Next, figure out where to place your implementation.  Look at all the files in
`parts/inc/` for one that fits what you're planning.  If there isn't one,
just start a new one and remember to include it from within `PPPort_pm.PL`.
If you do create a new file, it's usually the best approach to just copy an
existing file and use it as a template.

Each file holds all relevant data for implementing a certain part
of the API:

- A list of the provided API in the `=provides` section.
- The optional `=dontwarn` section is used to suppress warnings about particular
API elements.  Don't use this unless you get such a warning, and be sure to
think about using other other alternatives before resorting to adding something
in this section.
- The implementation to add to `ppport.h` in the `=implementation`
section.  See ["Implementation Section Details"](#implementation-section-details).
- The code required to add to PPPort.xs for testing the implementation.
This code goes into the `=xshead`, `=xsinit`, `=xsmisc`, `=xsboot`
and `=xsubs` section. Have a look at the template at the bottom
of `RealPPPort_xs.PL` to see where the code ends up.
- The tests in the `=tests` section. Remember not to use any fancy
modules or syntax elements, as the test code needs to be able to run
with Perl 5.003.  (This is because Devel::PPPort itself will run all test files
in the process of generating the information about when a feature came into
existence.)  This means, for example

    - `my` isn't supported in `for`-loops

            for my $x (1, 2, 3) { }    # won't work with 5.003

        Instead declare `$x` just before the statement

    - The postfix `for` statement modifier isn't supported

            foo for 1..2

        won't compile.  Instead enclose `foo` in a loop.

    - You can't use plain `qr//`

        Instead, wrap it in a string eval `eval "qr//"`, and be sure it's skipped at
        execution time on perls earlier than 5.005

    As of version 3.56 of Devel::PPPort, the old Test style tests have been
    replaced with the more modern Test::More style, with some limitations.  This
    means, for example, that `is` is finally available, as well as
    `done_testing`.  You can pass the number of tests to `skip`, instead of
    having to have your own `for` loop.

    There is no `like` nor `unlike` (as those require `qr` which didn't exist in
    the earliest perls that Devel::PPPort runs on).

    `skip` doesn't do a `last SKIP`.  (Perhaps it could, but that would mean
    converting all the skips in the existing tests.)

    The existing tests have been changed only as much as necessary so as to get
    things to work.  But feel free to use the full functionality for any new tests
    you write.

    Here's a list of the supported functions:

        cmp_ok
        curr_test
        diag
        display
        done_testing
        eq_array
        eq_hash
        fail
        is
        isnt
        next_test
        note
        ok
        pass
        plan
        skip
        skip_all
        within

    These are copied from `t/test.pl` in the perl distribution.  Not all of them
    have been tested back as far as Devel::PPPort supports.  Bug reports welcome.

    It's fine to backport an element only as far as convenient and necessary.  But
    remember that your test file will end up being called on all perl versions
    available, likely including ones earlier than your backport.  That may mean
    that elements in the `=xs` sections will have to be `#idef`'d out so that the
    object will not get missing symbols when loaded.

    It also means you have to check for and skip tests that aren't relevant to this
    version.  The recommended way to do this is like:

        if (ivers($]) < ivers(5.6)) {           # No quotes needed
           skip "reason", $count;
        }
        elsif (if (ivers($]) > ivers("5.5.4") { # Quotes needed for double-
                                                # dotted versions prior to 5.6.0
           skip "other reason", $count;
        }
        else {
           do_the_test
       }

    `ivers()` is a function automatically made available to all `.t` files.  It
    converts any reasonble expression of a version number into an integer, which
    can reliably be compared using numeric comparison operators, with the output of
    a second `ivers()` call on a different version number, like in the result above.

    It's worth emphasizing that, due to bugs in early perl parsing, if you use a
    version number containing two dots on a version befor 5.6.0, it has to be
    quoted.

In all sections, lines that begin with `##` are completely ignored.

## Implementation Section Details

You can implement API elements via C functions or macros, or simple variables.
It is preferable to use a macro if feasible.  Otherwise, the user must
explicitly request that it get loaded, by defining a `NEED__function_` (or
_variable_) as described in `ppport.h`.  If a function, _foo_ is required,
place its body in this `=implementation` section, like so:

    #if { NEED foo }

    char *
    foo(pTHX_ const U8 *arg1, const U32 arg2, ...)
    {
       ...
    }

    #endif

Similarly for a variable.

It's obviously best to use a macro if at all feasible.  Sometimes what once
was implemented with a macro now requires a function; perhaps an edge case was
overlooked.  Doing so will cause the new `ppport.h` to not be drop-in
compatible with the older version, and can hence cause breakage.  This
incompatiblity (while easily solved) really needs to be stressed in
documentation.

- \_\_UNDEFINED\_\_

    If you add the line `__UNDEFINED__` to the `=provides` section, you can use
    lines like this in the `=implementation` section:

        __UNDEFINED__ macro    some definition

    to both define `macro` and indicate that it is provided by `ppport.h`.  This
    replaces these `=implementation` section lines:

        #ifndef macro
        #  define macro    some definition
        #endif

    besides automagically making it be considered to be provided.  `macro` can
    have optional arguments and the definition can even span multiple lines, like
    in

        __UNDEFINED__ SvMAGIC_set(sv, val) \
                      STMT_START { assert(SvTYPE(sv) >= SVt_PVMG); \
                      (((XPVMG*) SvANY(sv))->xmg_magic = (val)); } \
                      STMT_END

    This usually makes the code more compact and readable.

    But you should only use this on things that you plan to publicly provide.  If
    something, such as a mnemonic for a constant needs to be defined but isn't
    really needed for the public at large to know about, you should use

        __UNDEF_NOT_PROVIDED__ macro   some definition

    instead.  To avoid name space conflicts, follow what's in ["Helper macros"](#helper-macros),
    below.

- Helper macros

    If you need to define a helper macro which is not part of `Devel::PPPort` API
    and its usage is only for the definition of other `Devel::PPPort` macros, then
    use the `D_PPP_` prefix for this macro name (e.g. `D_PPP_SVPV_NOLEN_LP_ARG`).
    This suppresses any warnings when a macro is defined which is not part of the
    Perl public API.

- Version numbers

    Version checking used to be tricky to get correct (besides being buggy in some
    perl versions).
    `ivers()` is used in the `=tests` section to overcome this. and constructs
    like the following in the C language sections.

        #if { VERSION < 5.9.3 }

    You SHOULD be using this construct or the alternatives listed below for ALL
    version checks, and not come up with something on your own.

    In this form, the version number can be either of the new form `5.x.y` or the
    older form `5.00x_yy`. Both are translated into the correct preprocessor
    statements. It is also possible to combine this with other statements:

        #if { VERSION >= 5.004 } && !defined(sv_vcatpvf)
          /* a */
        #elif { VERSION < 5.004_63 } && { VERSION != 5.004_05 }
          /* b */
        #endif

    This not only works in the `=implementation` section, but also in
    the `=xsubs`, `=xsinit`, `=xsmisc`, `=xshead` and `=xsboot` sections.

    Alternatively, you can use the forms now available in regular Perl:

        #if PERL_VERSION_EQ(5,9,3)
        #if PERL_VERSION_NE(5,9,3)
        #if PERL_VERSION_LT(5,9,3)
        #if PERL_VERSION_GT(5,9,3)
        #if PERL_VERSION_LE(5,9,3)
        #if PERL_VERSION_GE(5,9,3)

    These forms have the advantage over the '{ VERSION ... }' form in that you may
    use the special value '\*' for the final number to mean ALL possible values for
    it.  Thus,

        #if PERL_VERSION_EQ(5,31,'*')

    means all perls in the 5.31 series.  And

        #if PERL_VERSION_NE(5,24,'*')

    means all perls EXCEPT 5.24 ones.  And

        #if PERL_VERSION_LE(5,9,'*')

    is effectively

        #if PERL_VERSION_LT(5,10,0)

- Hints

    If you add a comment like so:

        /* Hint: PL_expect, PL_copline, PL_rsfp
           paragraphs of stuff you want to have shown when ppport.h outputs
           something about any one of PL_expect, PL_copline, or PL_rsfp
        */

    Earlier versions of `ppport.h` required an asterisk at the beginning of every
    continuation line, or else the content would be silently dropped.

- Warnings

    A more serious caution can be displayed by instead saying

        /* Warning: PL_expect, PL_copline, PL_rsfp
           paragraphs of stuff you want to have shown when ppport.h outputs
           something about any one of PL_expect, PL_copline, or PL_rsfp
        */

    Earlier versions of `ppport.h` required an asterisk at the beginning of every
    continuation line, or else the content would be silently dropped.

- Replace

    When `ppport.h` is run on a file(s), you can cause it to automatically flag
    occurrences of the constructs you specify, encouraging the author to replace
    them with different (presumably better) ones.  These also are used in any
    suggested edits and generated patches.

    There are three ways to do this

    - in-line comment

        You can add a trailing comment like so:

            #define bar foo    /* Replace */
            __UNDEFINED__ bar foo  /* Replace */

        These say that `foo` should be replaced by `bar`.  NOT the other way around.

    - separate comment

        For situations not amenable to the above, you can say

            /* Replace foo with bar */

    - define a replacement region

        It you have several replacements, you can group them together like so:

            /* Replace: 1 */
            #define foo bar
            #define bat baz
            /* Replace: 0 */

        These replace `bar` with `foo`; `baz` with `bat`.  NOT the other way
        around.

- Dependencies

    `ppport.h` automatically gathers information as to what functions are
    dependent on what other things from inspecting the source, but if this is
    insufficient for you, you can add lines like the following:

        /* foo, bar depends on baz, bat */

    Each of `foo`, `bar` depends on each of `baz`, `bat`.

## Testing

After you have furnished your implementation, you need to test it.

## Special Makefile targets

You can use

    make regen

to regenerate all of the autogenerated files. To get rid of all
generated files (except for `parts/todo/*` and `parts/base/*`),
use

    make purge_all

That's it.

To automatically test `Devel::PPPort` with lots of different Perl
versions, you can use the `soak` script. Just pass it a list of
all Perl binaries you want to test.

## Regenerating `ppport.h` and `PPPort.pm`

`Devel::PPPort` keeps two directories of generated files, in `parts/base` and
`parts/todo`.  The files in each are named after Perl version numbers.  When a
function or macro came into existence is indicated by placing its name in the
corresponding file in `parts/base`.  The files in `parts/todo` are the same,
except they indicate the earliest release that `ppport.h` supports the
element.  The delta is effectively what `ppport.h` buys you.

The generation process described in this section creates these files.  It does
so by examining as many perl versions as are available to it.  It tries to make
sure each element actually compiles, and it runs the test scripts you have
furnished on every version.

Ideally, this should be done before every release that includes new backporting
and/or when blead has added new public API.  At a minimum, it should be done as
the next major Perl release comes out.

The process isn't platform independent. It has currently been tested only under
Linux, and it definitely requires at least `gcc` and the `nm` utility.
The process used to be problematic, with random failures.  But it has now been
fixed to be reliable.

Before starting the regeneration, you need to have gathered certain data.
(Options listed below apply to the tools that eventually will use the data, and
which are described further below).

- You will first need a whole bunch of different Perls, the more, the better, but
only one per version tag (which one is random) will actually get used.
dromedary has a sufficient set.  They should all have the same Configure
options with respect to what functions and macros are enabled.  For example,
they should all be threaded, or all non-threaded.  A mixture will screw up the
results.  Similarly, they should all or none have quad math (at least as far
back as that became available).  You can use `devel/buildperl.pl` to build
them.

    Previous maintainers of this module kept those perls in
    `/tmp/perl/install/default`, so most of the tools use this as a default, but
    you'll likely simply use the `--install=` option to specify where.  This
    should be a path where a `make install` has been done, so has immediate
    subdirectories of `/bin` and `/lib`.  `/bin` should contain the binaries.
    It will use all files in this directory whose names begin with `perl5`.

    Actually, not all the binaries need be in this directory.  You can specify
    additional places to look since `--install=` takes a comma separated list of
    directories.

- You also need a freshly built bleadperl.  The `--blead=_path_` option should
be used to specify it.  (Some of the tools have a default of `bleadperl-debug`
if this option is omitted.)  Again, it needs the same Configure options as the
earlier versions had.  Using `-DNO_MATHOMS` will change the results, and
probably should be avoided.  True, these functions are allegedly on their way
out, so it could be argued that they shouldn't be encouraged in any way; but
some of these have been in limbo for many years, so should be documented.
- And you will need updated API information. Copy the latest `embed.fnc` file
from bleadperl to the `parts` directory and run `devel/mkapidoc.pl` to
collect the remaining information in `parts/apidoc.fnc`.  This needs to be
done after the perl has been compiled, as there are generated files that feed
it.
- The final step before regenerating everything is to run
`devel/mkppport_fnc.pl` to update the `/parts/ppport.fnc` file.

Having done this, run `devel/regenerate` which wraps the following steps
(which you could instead do by hand, but it's easy to forget things):

- It first does some sanity checking
- Then it asks you if it's ok to remove all existing todo files in the
`parts/base` and `parts/todo` directories.  If you answer no, the process
aborts.

    This is crtical to getting accurate results.

- It builds the new baseline by running

        perl devel/mktodo --base

    in the root directory of the distribution.

    If there are warnings in blead, it will ask you to examine them, and to ok if
    it's all right to go ahead.  If there are issues with blead, everything
    following could be wrong.

- It builds the new todo files by running

        perl devel/mktodo

    in the root directory of the distribution.

- Finally, it adds the remaining information by running

        perl Makefile.PL && make
        perl devel/scanprov --mode=write

## How to build gobs of versions of Perl

`Devel::PPPort` supports Perl versions between 5.003 and bleadperl.
To guarantee this support, its good to have as many versions as possible to
test on.  dromedary currently has many such versions.

There is a tool to build all the different
versions and configurations. You can find it in `devel/buildperl.pl`.
It can currently build the following Perl releases:

    5.003
    5.004 - 5.004_05
    5.005 - 5.005_04
    5.6.x
    5.7.x
    5.8.x
    5.9.x
    5.1x.x
    5.2x.x
    5.3x.x

## Implementation

Knowing which parts of the API are not backwards compatible and
probably need `Devel::PPPort` support is another problem that's
not easy to deal with manually. If you run

    perl Makefile.PL --with-apicheck

a C file is generated by `parts/apicheck.pl` that is compiled
and linked with `Devel::PPPort`. This C file has the purpose of
using each of the public API functions/macros once.

The required information is derived from `parts/embed.fnc` (just
a copy of bleadperl's `embed.fnc`), `parts/apidoc.fnc` (which
is generated by `devel/mkapidoc.pl` and simply collects the rest
of the apidoc entries spread over the Perl source code) and
`parts/ppport.fnc` (which lists the API provided purely by
Devel::PPPort, along with other elements that are tested only using
`ppport.h`).

The generated C file (usually, `apicheck.c`) won't compile as-is
with older perls. And even if it compiles, there's still a good chance of the
dynamic linker failing at `make test` time. But that's on purpose!

We can use these failures to find changes in the API automatically.
The Perl script `devel/mktodo` calls another script `devel/mktodo.pl`
repeatedly to run `Devel::PPPort` on version after version of perl, in
decreasing version order, so we start with blead and work backwards.  The
latter script generates an `apicheck.c`.  It starts with the code that
successfully worked in the previously tested Perl version, which should be the
version one higher than the current one.  Call the current one _n_, and the
previous one _n+1_.  The items that fail to compile in _n_, but did compile
in _n+1_ must have become available in _n+1_.  We run the Linux command `nm`
to find those undefined symbols in _n_.  We change `apicheck.c` to ignore
(through `#ifdef`'s) those and recompile, repeating until `apicheck.c`
successfully compiles, the dynamic linker is happy, and `make test` runs on
this version.  Then we repeat the process for _n-1_, and so on.  (Actually,
this process may generate false positives, so by default each failing API call
is checked again.  If possible, this is done by generating an `apicheck.c` for
just the one failing API.)  Note that the make test is run using `ppport.h`
during both passes.

Running `devel/mktodo` currently takes a couple hours on dromedary.

If you run it with the `--nocheck` option, it won't recheck the API calls
that failed in the compilation stage and it'll take significantly less time.
No one currently associated with maintaining this module understands under what
circumstances it is safe to run with `--nocheck`.

By repeating the process over and over, we build up information on when every
element first became supported.  This information is stored in files in the
`parts/base` directory, one file per version.  The file for version _n+1_ is
generated by running version _n_ of perl.

We actually want a second piece of information, which is how much `ppport.h`
buys you.  What happens when regenerating is actually two entire runs through
all the perls.  The first is accomplished by calling `devel/mktodo` with the
`--base` option.  It automically will call `devel/mktodo.pl` with each
version of perl, NOT using anything in `ppport.h`.  When done the results
indicate  when each API element became available in stock perl, without using
`ppport.h`.

And then the whole process is repeated, but this time `ppport.h` is included.
The files are placed in `parts/todo`.  Thus, at the end, we know when each
element became available in modified perl, using `ppport.h`.

However, only the public API that is implemented as functions (and must appear
in `embed.fnc`) plus macros whose calling sequence is documented can be
checked this way.  The final step in the process is calling `devel/scanprov`.
It looks through the header files for when all the symbols provided by
`Devel::PPPort` first became defined.  It doesn't test the symbols or try to
compile them, as it doesn't generally know the API, but it can tell that
something exists in release _n+1_ but not _n_ (by scanning the include files
in the `CORE` directory of various Perl versions).  (It does know if a macro
has zero arguments or non-zero arguments, so it does get extra information from
the zero argument ones.)

## Files

Residing in `parts/inc/` is the "heart" of `Devel::PPPort`. Each
of the files implements a part of the supported API, along with
hints, dependency information, XS code and tests.
The files are in a POD-like format that is parsed using the
functions in `parts/ppptools.pl`.

The scripts `PPPort_pm.PL`, `RealPPPort_xs.PL` and `mktests.PL` all
use the information in `parts/inc/` to generate the main module
`PPPort.pm`, the XS code in `RealPPPort.xs` and various test files
in `t/`.

You can get extra information from `PPPort_pm.PL` by setting the environment
variable `DPPP_CHECK_LEVEL` to 1 or 2.

All of these files could be generated on the fly while building
`Devel::PPPort`, but not having the tests in `t/` will confuse
TEST/harness in the core. Not having `PPPort.pm` will be bad for
viewing the docs on `search.cpan.org`. So unfortunately, it's
unavoidable to put some redundancy into the package.

## Submitting Patches

If you've added some functionality to `Devel::PPPort`, please
consider submitting a patch with your work to P5P by sending a pull request to

[https://github.com/Dual-Life/Devel-PPPort/pulls](https://github.com/Dual-Life/Devel-PPPort/pulls).

When submitting patches, please only add the relevant changes
and don't include the differences of the generated files. You
can use the `purge_all` target to delete all autogenerated
files.

## Integrating into the Perl core

When integrating this module into the Perl core, be sure to
remove the following files from the distribution. They are
either not needed or generated on the fly when building this
module in the core:

    MANIFEST
    META.yml
    PPPort.pm

# BUGS

No known bugs.

# COPYRIGHT

Version 3.x, Copyright (C) 2004-2020, Marcus Holland-Moritz
and Perl 5 porters

Version 2.x, Copyright (C) 2001, Paul Marquess.

Version 1.x, Copyright (C) 1999, Kenneth Albanowski.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

# SEE ALSO

See `ppport.h` and `devel/regenerate`.
