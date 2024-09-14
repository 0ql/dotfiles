#!/bin/bash

CONFIG_FILES="./config.jsonc ./style.css"

trap "killall waybar" EXIT

while true; do
	waybar -c ./config.jsonc -s ./style.css &
	inotifywait -e create,modify $CONFIG_FILES
	killall waybar
done
