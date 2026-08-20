set -uo pipefail

fail_picker() {
    printf 'The session picker failed.\n' >&2
    printf 'Press enter to close this window.\n' >&2
    read -r _
    exit 1
}

if [ -n "${HERDR_ENV-}" ]; then
    printf 'herdr-session-loop cannot run inside a herdr pane.\n' >&2
    printf 'Detach first, or open a new terminal.\n' >&2
    exit 1
fi

target="${1-default}"

while [ -n "$target" ]; do
    if ! herdr --session "$target"; then
        printf 'herdr could not open session %s\n' "$target" >&2
        sleep 1
    fi
    target=$(herdr-session-picker) || fail_picker
done
