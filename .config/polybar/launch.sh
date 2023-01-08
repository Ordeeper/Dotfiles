#!/usr/bin/env bash

# Terminate already running bar instances
if pgrep -x polybar > /dev/null; then
    # If all your bars have ipc enabled, you can use 
    polybar-msg cmd quit
    # Otherwise you can use the nuclear option:
    # killall -q polybar

    sleep 0.03
fi

# Launch Skybar
echo "---" | tee -a /tmp/polybar1.log
polybar skybar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
