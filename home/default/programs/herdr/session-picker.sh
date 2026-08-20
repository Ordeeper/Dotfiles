set +o errexit
set -uo pipefail

backend="${SESSION_PICKER_BACKEND:?}"

case "${1-}" in
    --rows)
        python3 "$backend" rows "${2-}"
        exit 0
        ;;
    --preview)
        python3 "$backend" preview "${2-}" "${3-}"
        exit 0
        ;;
    --delete)
        python3 "$backend" delete "${2-}"
        exit 0
        ;;
esac

while true; do
    result=$("$0" --rows | fzf --print-query \
        --height=100% --layout=reverse --border=rounded \
        --border-label=" herdr sessions " \
        --prompt="attach > " \
        --header="enter: attach    type a name to create    ctrl-x: delete    esc: close terminal" \
        --preview "$0 --preview {1} {q}" \
        --preview-window="right,55%,border-left" \
        --bind "change:reload($0 --rows {q})" \
        --bind "ctrl-x:execute-silent($0 --delete {1})+reload($0 --rows {q})" \
        --color="border:6,label:6,prompt:5,header:8,pointer:5")
    status=$?

    if [ "$status" -eq 130 ]; then
        exit 0
    fi

    if [ "$status" -ne 0 ] && [ "$status" -ne 1 ]; then
        exit 1
    fi

    { read -r query; read -r picked; } <<< "$result"
    chosen="${picked%% *}"

    if [ -n "$chosen" ] && [ "$chosen" != "+" ]; then
        printf '%s\n' "$chosen"
        exit 0
    fi

    if [ -z "$query" ]; then
        exit 0
    fi

    if [[ $query =~ ^[A-Za-z0-9._-]+$ ]]; then
        printf '%s\n' "$query"
        exit 0
    fi

    printf 'Session names allow letters, digits, dot, dash and underscore only.' > /dev/tty
    sleep 1.5
done
