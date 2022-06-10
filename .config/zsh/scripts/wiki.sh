#!/bin/bash

wikidir=/usr/share/doc/arch-wiki/html/en
choise=$(printf '%s\n' $(find $wikidir -iname "*.html") | \
  grep -oP '(?<=/usr/share/doc/arch-wiki/html/en/).*(?=.html)' | \
  sed -e 's/_/ /g' | \
  awk '{print tolower($0)}' | \
  sort -g | \
  rofi -dmenu -l 20 -p 'docs: ')

if ! [[ -n $choise ]]; then
  exit
fi

filechoise=$(find $wikidir -type f -iname "$(echo $choise | sed -e 's/ /_/g')*")
surf $filechoise
