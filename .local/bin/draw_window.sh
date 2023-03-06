#!/usr/bin/env bash
# Dependencies slop, wmctrl, and xdotool

geometry=$(slop -f '0, %x, %y, %w, %h');

# Checks if slop is executed successfully
if [ $? -eq 0 ]; then
        # Opens kitty and keeps the pid
        /usr/bin/kitty &
        id=$!;

        # Checks if kitty is opened
        while ! [ $(xdotool search --pid $id) ]
            do
	       sleep 0.06;
            done

        # Toggles window to floating mode
        id=$(xdotool search --pid $id);
        i3-msg "[id=$id]" floating enable;

        # Takes the kitty id then reposition and resize
        wmctrl -i -r "$id" -e "$geometry";
	exit 0
    else
        exit 1
    fi
