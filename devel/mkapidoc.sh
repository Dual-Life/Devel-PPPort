#!/bin/bash
function isperlroot
{
  [ -f "$1/embed.fnc" ] && [ -f "$1/perl.h" ]
}

function usage
{
  echo "USAGE: $0 [perlroot] [output-file]"
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

if isperlroot $PERLROOT; then
  grep -hr '=for apidoc' $PERLROOT | sed -e 's/=for apidoc //' | sort | uniq | grep '|' >$OUTPUT
else
  usage
fi
