import json
import os
import socket
import sys

sock_path = os.environ.get("HERDR_SOCKET_PATH") or os.path.expanduser("~/.config/herdr/herdr.sock")


def fail(message):
    sys.exit(f"herdr-balance: {message}")


def call(method, params, tolerate=()):
    buf = b""
    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
            sock.settimeout(5)
            sock.connect(sock_path)
            sock.sendall((json.dumps({"id": "balance", "method": method, "params": params}) + "\n").encode())
            while b"\n" not in buf:
                chunk = sock.recv(65536)
                if not chunk:
                    break
                buf += chunk
    except OSError as err:
        fail(f"cannot reach the herdr server ({err})")

    try:
        reply = json.loads(buf.decode().split("\n")[0])
    except (UnicodeDecodeError, json.JSONDecodeError):
        fail(f"invalid reply to {method}")

    if not isinstance(reply, dict):
        fail(f"invalid reply to {method}")

    if "error" in reply:
        error = reply["error"]
        if isinstance(error, dict) and error.get("code") in tolerate:
            return None
        fail(f"{method}: {error.get('message', error) if isinstance(error, dict) else error}")

    if "result" not in reply:
        fail(f"reply to {method} carried no result")
    return reply["result"]


def leaves(node):
    if node.get("type") != "split":
        return 1
    return leaves(node["first"]) + leaves(node["second"])


def even_ratios(node, path=()):
    if node.get("type") != "split":
        return
    first = leaves(node["first"])
    yield list(path), first / (first + leaves(node["second"]))
    yield from even_ratios(node["first"], path + (False,))
    yield from even_ratios(node["second"], path + (True,))


target = os.environ.get("HERDR_ACTIVE_PANE_ID") or os.environ.get("HERDR_PANE_ID")
layout = call("layout.export", {"pane_id": target} if target else {})["layout"]
pane_id = target or layout["focused_pane_id"]

for path, ratio in even_ratios(layout["root"]):
    call(
        "layout.set_split_ratio",
        {"pane_id": pane_id, "path": path, "ratio": ratio},
        tolerate=("split_not_found",),
    )
