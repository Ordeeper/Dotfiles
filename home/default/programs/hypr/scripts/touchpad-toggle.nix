{ pkgs, ... }:

let
  toggle-touchpad = pkgs.writeShellApplication {
    name = "toggle-touchpad";
    runtimeInputs = with pkgs; [ jq hyprland coreutils libnotify ];
    text = ''
      STATE_FILE="''${XDG_RUNTIME_DIR:-/tmp}/touchpad-toggle-state"

      JSON=$(hyprctl devices -j)

      TOUCHPADS=$(echo "$JSON" | jq -c '
        (
          (.touchpads // []) +
          (.touch // [])
        )[]
      ' 2>/dev/null)

      if [ -z "$TOUCHPADS" ]; then
          TOUCHPADS=$(echo "$JSON" | jq -c '
            (.mice // [])[] | select(.name | test("touchpad|trackpad|glidepoint"; "i"))
          ' 2>/dev/null)
      fi

      if [ -z "$TOUCHPADS" ]; then
          notify-send "Touchpad" "No touchpad detected" -i dialog-warning -t 3000
          exit 0
      fi

      if [ -f "$STATE_FILE" ]; then
          CURRENT_STATE=$(cat "$STATE_FILE")
      else
          CURRENT_STATE=1
      fi

      if [ "$CURRENT_STATE" = "1" ]; then
          NEW_STATE=0
          MSG="Touchpad Disabled"
      else
          NEW_STATE=1
          MSG="Touchpad Enabled"
      fi

      echo "$TOUCHPADS" | while read -r device; do
          NAME=$(echo "$device" | jq -r '.name')
          hyprctl keyword "device[$NAME]:enabled" "$NEW_STATE"
      done

      echo "$NEW_STATE" > "$STATE_FILE"

      notify-send "Hyprland" "$MSG" -i input-touchpad -t 2000
    '';
  };
in
{
  home.packages = with pkgs; [
    toggle-touchpad
    jq
    libnotify
  ];
}