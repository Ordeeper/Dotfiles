import json
import os
import socket
import subprocess
import sys
import time

PINNED = ["default", "scratchpad"]


def sessions():
    raw = subprocess.run(
        ["herdr", "session", "list", "--json"], capture_output=True, text=True
    ).stdout
    try:
        entries = json.loads(raw).get("sessions", [])
    except Exception:
        return {}
    return {e["name"]: e.get("socket_path", "") for e in entries if "name" in e}


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


def attached():
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
    return found


def rows(query):
    existing = sessions()
    live = attached()
    for name in PINNED + [n for n in existing if n not in PINNED]:
        if name in live:
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


def tabs(socket_path):
    raw = subprocess.run(
        ["herdr", "tab", "list"],
        capture_output=True,
        text=True,
        env=dict(os.environ, HERDR_SOCKET_PATH=socket_path),
    ).stdout
    try:
        payload = json.loads(raw)
    except Exception:
        print("  Session is not reachable.")
        return
    if "result" not in payload:
        print("  Session is stopped.")
        return
    entries = payload["result"].get("tabs", [])
    if not entries:
        print("  Empty session.")
        return
    groups = {}
    for tab in entries:
        groups.setdefault(tab["workspace_id"], []).append(tab)
    for workspace, items in groups.items():
        print("  workspace " + workspace)
        for tab in items:
            mark = "*" if tab["focused"] else " "
            print(
                "    {} tab {:<12} {} pane(s)   agent: {}".format(
                    mark, tab["label"], tab["pane_count"], tab["agent_status"]
                )
            )


def preview(name, query):
    if name == "+":
        if query:
            print("  Creates a new session named:\n")
            print("    " + query)
        else:
            print("  Type a name to create a new session.")
        return
    socket_path = sessions().get(name)
    if not socket_path:
        print("  Not created yet.")
        print("  Picking it starts an empty session.")
        return
    tabs(socket_path)


def delete(name):
    if not name or name in ("default", "+") or name in attached():
        return
    for action in ("stop", "delete"):
        subprocess.run(
            ["herdr", "session", action, name],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        time.sleep(0.4)


command = sys.argv[1] if len(sys.argv) > 1 else ""
argument = sys.argv[2] if len(sys.argv) > 2 else ""
extra = sys.argv[3] if len(sys.argv) > 3 else ""

if command == "rows":
    rows(argument.strip())
elif command == "preview":
    preview(argument, extra.strip())
elif command == "delete":
    delete(argument)
else:
    sys.exit("usage: session-picker.py rows|preview|delete [args]")
