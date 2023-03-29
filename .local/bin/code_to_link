#!/usr/bin/env bash
# Dependencies flameshot, zbar and xclip

# Takes the Screenshot
flameshot gui -p /tmp/zbar_screenshot.png;

# Copy link from Image
zbarimg -q --raw /tmp/zbar_screenshot.png | xclip -selection clipboard;

# Delete Last Screenshot
rm /tmp/zbar_screenshot.png;

# Set the exit status based on whether the last command succeeded or failed
if [ $? -eq 0 ]; then
    exit 0;  # Success
else
    exit 1;  # Error
fi
