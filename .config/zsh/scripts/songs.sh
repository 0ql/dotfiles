#!/bin/bash

if ! [[ -d ~/Music ]]; then
  exit
fi

cd ~/Music

choise=$(printf '%s\n' $(find -type d) | \
  awk '{print tolower($0)}' | \
  sort -g | \
  rofi -dmenu -l 15 -p 'Choose Song Directory: ')

cd "$choise"

choise=$(ls | awk '{print $0}' | \
  sort -g | \
  rofi -dmenu -l 15 -p 'Choose Song: ')

ffplay "$choise"
