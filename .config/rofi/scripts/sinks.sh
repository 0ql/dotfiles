#!/bin/bash

if [[ -n $1 ]]; then
  pactl set-default-sink $1
  exit 0
fi

pactl list sinks short | awk '{print $2}'
