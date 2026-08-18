set +o errexit
set -uo pipefail

socket_py=$(cat <<'PY'
import json, sys
name = sys.argv[1]
try:
    entries = json.load(sys.stdin).get("sessions", [])
except Exception:
    sys.exit(0)
for entry in entries:
    if entry.get("name") == name:
        print(entry.get("socket_path", ""))
        break
PY
)

tabs_py=$(cat <<'PY'
import json, sys
try:
    payload = json.load(sys.stdin)
except Exception:
    print("  Session is not reachable.")
    sys.exit()
if "result" not in payload:
    print("  Session is stopped.")
    sys.exit()
tabs = payload["result"].get("tabs", [])
if not tabs:
    print("  Empty session.")
    sys.exit()
groups = {}
for tab in tabs:
    groups.setdefault(tab["workspace_id"], []).append(tab)
for workspace, entries in groups.items():
    print("  workspace " + workspace)
    for tab in entries:
        mark = "*" if tab["focused"] else " "
        label = tab["label"]
        panes = tab["pane_count"]
        status = tab["agent_status"]
        print("    {} tab {:<12} {} pane(s)   agent: {}".format(mark, label, panes, status))
PY
)

attached_py=$(cat <<'PY'
import os, sys


def session_of(parts):
    if not parts or os.path.basename(parts[0]) != "herdr":
        return None
    rest = parts[1:]
    if rest[:1] == ["server"]:
        return None
    for index, item in enumerate(rest):
        if item == "--session" and index + 1 < len(rest):
            return rest[index + 1]
    if rest[:2] == ["session", "attach"] and len(rest) >= 3:
        return rest[2]
    if not rest:
        return "default"
    return None


found = set()
for pid in os.listdir("/proc"):
    if not pid.isdigit():
        continue
    try:
        with open("/proc/" + pid + "/cmdline", "rb") as handle:
            parts = [p.decode(errors="replace") for p in handle.read().split(b"\x00") if p]
    except OSError:
        continue
    name = session_of(parts)
    if name:
        found.add(name)

wanted = sys.argv[1] if len(sys.argv) > 1 else None
if wanted:
    sys.exit(0 if wanted in found else 1)
for name in sorted(found):
    print(name)
PY
)

rows_py=$(cat <<'PY'
import json, subprocess, sys

PINNED = ["default", "scratchpad"]

query = sys.argv[1].strip() if len(sys.argv) > 1 else ""

raw = subprocess.run(["herdr", "session", "list", "--json"], capture_output=True, text=True).stdout
try:
    existing = [s["name"] for s in json.loads(raw).get("sessions", [])]
except Exception:
    existing = []

attached = set(sys.stdin.read().split())

for name in PINNED + [n for n in existing if n not in PINNED]:
    if name in attached:
        note = "open in another window"
    elif name in existing:
        note = ""
    else:
        note = "not created yet"
    print("{:<20}  {}".format(name, note))

if query:
    print("{:<20}  create {}".format("+", query))
else:
    print("{:<20}  new session, type a name".format("+"))
PY
)

valid_name() {
    printf '%s' "$1" | grep -qE '^[A-Za-z0-9._-]+$'
}

case "${1-}" in
    --rows)
        python3 -c "$attached_py" | python3 -c "$rows_py" "${2-}"
        exit 0
        ;;
    --preview)
        name="${2-}"
        if [ "$name" = "+" ]; then
            if [ -n "${3-}" ]; then
                printf '  Creates a new session named:\n\n    %s\n' "${3-}"
            else
                echo "  Type a name to create a new session."
            fi
            exit 0
        fi
        socket=$(herdr session list --json 2>/dev/null | python3 -c "$socket_py" "$name")
        if [ -z "$socket" ]; then
            echo "  Not created yet."
            echo "  Picking it starts an empty session."
            exit 0
        fi
        HERDR_SOCKET_PATH="$socket" herdr tab list 2>/dev/null | python3 -c "$tabs_py"
        exit 0
        ;;
    --delete)
        name="${2-}"
        if [ -z "$name" ] || [ "$name" = "default" ] || [ "$name" = "+" ]; then
            exit 0
        fi
        if python3 -c "$attached_py" "$name"; then
            exit 0
        fi
        herdr session stop "$name" >/dev/null 2>&1
        sleep 0.4
        herdr session delete "$name" >/dev/null 2>&1
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

    query=$(printf '%s\n' "$result" | sed -n 1p | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    picked=$(printf '%s\n' "$result" | sed -n 2p)

    if [ -n "$picked" ]; then
        chosen=$(printf '%s' "$picked" | awk '{print $1}')
        if [ "$chosen" != "+" ]; then
            printf '%s\n' "$chosen"
            exit 0
        fi
    fi

    if [ -z "$query" ]; then
        if [ -n "$picked" ]; then
            continue
        fi
        exit 0
    fi

    if valid_name "$query"; then
        printf '%s\n' "$query"
        exit 0
    fi

    printf 'Session names allow letters, digits, dot, dash and underscore only.' > /dev/tty
    sleep 1.5
done
