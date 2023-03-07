#!/usr/bin/env bash
# Dependencies slop, wmctrl, and xdotool

# Takes the area geometry and position
geometry=$(slop -f '0, %x, %y, %w, %h');

# Checks if slop was executed successfully
if [ $? -eq 0 ]
then
    # Opens kitty and keeps the pid
    /usr/bin/kitty &
    pid=$!;

    # Checks if kitty is opened and takes the window id
    until id=$(xdotool search --pid $pid)
        do
	    sleep 0.06;
        done

    # Toggles window to floating mode
    i3-msg "[id=$id]" floating enable;

    # Takes the kitty id then reposition and resize
    wmctrl -i -r "$id" -e "$geometry";
    exit 0
else
    exit 1
fi
