#!/usr/bin/env bash
# Dependencies slop, xdotool, xwininfo and wmctrl

clear
echo ""
echo ""
echo " ▒█████   ██▀███  ▓█████▄ ▓█████ ▓█████  ██▓███  ▓█████  ██▀███  "
echo "▒██▒  ██▒▓██ ▒ ██▒▒██▀ ██▌▓█   ▀ ▓█   ▀ ▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒"
echo "▒██░  ██▒▓██ ░▄█ ▒░██   █▌▒███   ▒███   ▓██░ ██▓▒▒███   ▓██ ░▄█ ▒"
echo "▒██   ██░▒██▀▀█▄  ░▓█▄   ▌▒▓█  ▄ ▒▓█  ▄ ▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄  "
echo "░ ████▓▒░░██▓ ▒██▒░▒████▓ ░▒████▒░▒████▒▒██▒ ░  ░░▒████▒░██▓ ▒██▒"
echo "░ ▒░▒░▒░ ░ ▒▓ ░▒▓░ ▒▒▓  ▒ ░░ ▒░ ░░░ ▒░ ░▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░"
echo "  ░ ▒ ▒░   ░▒ ░ ▒░ ░ ▒  ▒  ░ ░  ░ ░ ░  ░░▒ ░      ░ ░  ░  ░▒ ░ ▒░"
echo "░ ░ ░ ▒    ░░   ░  ░ ░  ░    ░      ░   ░░          ░     ░░   ░ "
echo "    ░ ░     ░        ░       ░  ░   ░  ░            ░  ░   ░     "
echo "                   ░                                             "
echo ""
echo "                   https://github.com/Ordeeper                   "
echo ""
echo ""

# Take the area geometry and position
geometry=$(slop -f '0, %x, %y, %w, %h');

# Check if slop was executed successfully
if [ $? -eq 0 ]
then
    # Open kitty
    /usr/bin/kitty &

    # Store the pid
    pid=$!;

    # Take the window id
    until id=$(xdotool search --pid "$pid") 1>/dev/null
	do
	    sleep 0.1;
	done

    # Check if the window id is the same and if it is visible
    until xwininfo -id "$id" | grep -q "IsViewable" 1>/dev/null
        do
            id=$(xdotool search --pid "$pid");
            sleep 0.1;
        done

    # Toggle window to floating mode
    i3-msg "[id=$id]" floating enable;

    # Take the kitty id then reposition and resize
    wmctrl -i -r "$id" -e "$geometry";
    exit 0;
else
    exit 1;
fi
