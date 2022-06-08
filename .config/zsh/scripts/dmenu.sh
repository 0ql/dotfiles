#!/bin/bash

wikidir=/usr/share/doc/arch-wiki/html/en
choise=$(printf '%s\n' $(find ${wikidir} -iname "*.html") | \
  grep -oP '(?<=/usr/share/doc/arch-wiki/html/en/).*(?=.html)' | \
  sed -e 's/_/ /g' | \
  awk '{print tolower($0)}' | \
  sort -g | \
  dmenu -l 20 -p 'docs: ')

filechoise=$(find /usr/share/doc/arch-wiki/html/en/ -type f -iname "$(echo $choise | sed -e 's/ /_/g')*")
xdg-open $filechoise
