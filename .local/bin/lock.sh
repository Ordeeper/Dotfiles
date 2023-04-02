#!/usr/bin/env bash
# Dependencies scrot, corrupter and i3lock-color

# Import Pywal theme file
. "${HOME}/.cache/wal/colors.sh";

# Path and name to temporary background
tmpbg="/tmp/corrupter_screen.png";

# Take screenshot and corrupt it
scrot "$tmpbg"; corrupter "$tmpbg" "$tmpbg";

# Color Variables
BLANK="$background";
CLEAR="$background";
DEFAULT="$color6";
TEXT="$color6";
WRONG="$background";
VERIFYING="$background";

i3lock -i "$tmpbg" \
--ring-width=3.9 \
\
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
\
--clock                      \
--indicator                  \
--time-str="%l:%M %p"        \
--date-str="%b %d, %Y"       \

# Remove temporary background
rm "$tmpbg";
