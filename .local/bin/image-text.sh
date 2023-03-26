#!/usr/bin/env bash
# Dependencies flameshot, xclip, tesseract, tesseract-data-eng and tesseract-data-por

# Takes the Screenshot
flameshot gui -p /tmp/screenshot.png

# Copy Text from Image
tesseract /tmp/screenshot.png stdout -l eng+por | xclip -selection clipboard;

# Delete Last Screenshot
rm /tmp/screenshot.png;
