#!/bin/bash

if [[ -n $1 ]]; then
  pactl set-default-sink $1
  exit 0
fi

# echo -en "\0prompt\x1fChange prompt\n"
pactl list sinks short | awk '{print $2}'
