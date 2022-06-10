#!/bin/bash

if [[ -n $1 ]]; then
  pactl set-default-sink $1
  exit 0
fi

pamixer --list-sinks | grep -oP '[0-9]*(?<=")[0-9A-Za-z-_\s]{2,}(?=")'
