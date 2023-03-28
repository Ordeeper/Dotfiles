#!/usr/bin/env bash
# Dependencies slop, xdotool, xwininfo and wmctrl

# Takes the area geometry and position
geometry=$(slop -f '0, %x, %y, %w, %h');

# Checks if slop was executed successfully
if [ $? -eq 0 ]
then
    # Opens kitty
    /usr/bin/kitty &

    # Stores the pid
    pid=$!;

    # Takes the window id
    until id=$(xdotool search --pid "$pid") 1>/dev/null
	do
	    sleep 0.1;
	done

    # Checks if the window id is the same and if it is visible
    until xwininfo -id "$id" | grep -q "IsViewable" 1>/dev/null
        do
            id=$(xdotool search --pid "$pid");
            sleep 0.1;
        done

    # Toggles window to floating mode
    i3-msg "[id=$id]" floating enable;

    # Takes the kitty id then reposition and resize
    wmctrl -i -r "$id" -e "$geometry";
    exit 0;
else
    exit 1;
fi
