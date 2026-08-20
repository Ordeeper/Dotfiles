set -uo pipefail

file=$(mktemp --suffix=.png -p "${XDG_RUNTIME_DIR:-/tmp}")
trap 'rm -f "$file"' EXIT

grimblast --freeze copysave area "$file" || exit 0

satty --filename "$file" \
    --output-filename "$HOME/Pictures/Screenshots/%Y%m%d-%H%M%S.png" \
    --copy-command wl-copy \
    --actions-on-enter save-to-clipboard,exit
