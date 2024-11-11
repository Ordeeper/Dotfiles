#!/usr/bin/env bash

wal-telegram -r
pywalfox update

wallpaper_path=$(awk -F"'" '/feh/ {print $2}' ~/.fehbg)

if [ -n "$wallpaper_path" ]; then
    wpg -s "$wallpaper_path"
else
    echo "Error: Wallpaper path not found in ~/.fehbg"
fi
