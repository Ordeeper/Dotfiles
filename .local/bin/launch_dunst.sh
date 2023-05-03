#!/bin/bash

# Start dunst
if pgrep -x dunst > /dev/null; then
    killall -q dunst
fi

# Monitor the dunstrc file for changes
while true; do
  inotifywait -e modify $HOME/.config/dunst/dunstrc &> /dev/null
  killall -q dunst
  dunst &
done
