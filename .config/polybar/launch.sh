#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch Skybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload skybar &
done
