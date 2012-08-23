#!/bin/bash
function isperlroot
{
  [ -f "$1/embed.fnc" ] && [ -f "$1/perl.h" ]
}

function usage
{
  echo "USAGE: $0 [perlroot] [output-file] [embed.fnc]"
  exit 0
}

if [ -z "$1" ]; then
  if isperlroot "../../.."; then
    PERLROOT=../../..
  else
    PERLROOT=.
  fi
else
  PERLROOT=$1
fi

if [ -z "$2" ]; then
  if [ -f "parts/apidoc.fnc" ]; then
    OUTPUT="parts/apidoc.fnc"
  else
    usage
  fi
else
  OUTPUT=$2
fi

if [ -z "$3" ]; then
  if [ -f "parts/embed.fnc" ]; then
    EMBED="parts/embed.fnc"
  else
    usage
  fi
else
  EMBED=$3
fi

if isperlroot $PERLROOT; then
  grep -hr '=for apidoc' $PERLROOT | sed -e 's/=for apidoc //' | grep '|' | sort | uniq \
     | perl -e'$f=pop;open(F,$f)||die"$f:$!";while(<F>){(split/\|/)[2]=~/(\w+)/;$h{$1}++}
               while(<>){(split/\|/)[2]=~/(\w+)/;$h{$1}||print}' $EMBED >$OUTPUT
else
  usage
fi
