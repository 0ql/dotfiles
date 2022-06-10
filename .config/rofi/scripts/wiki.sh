#!/bin/bash

# wikidir=/usr/share/doc/arch-wiki/html/en
# choise=$(printf '%s\n' $(find $wikidir -iname "*.html") | \
#   grep -oP '(?<=/usr/share/doc/arch-wiki/html/en/).*(?=.html)' | \
#   sed -e 's/_/ /g' | \
#   awk '{print tolower($0)}' | \
#   sort -g | \
#   rofi -dmenu -l 20 -p 'docs: ')

# filechoise=$(find $wikidir -type f -iname "$(echo $choise | sed -e 's/ /_/g')*")
# xdg-open $filechoise

wikidir=/usr/share/doc/arch-wiki/html/en
if [[ -n $1 ]]; then
  uri=$(find $wikidir -type f -iname "$(echo $1 | sed -e 's/ /_/g')*")
  exit 0 & xdg-open $uri
fi

find $wikidir -iname "*.html" | \
  grep -oP '(?<=/usr/share/doc/arch-wiki/html/en/).*(?=.html)' | \
  sed -e 's/_/ /g' | \
  awk '{print tolower($0)}' | \
  sort -g
