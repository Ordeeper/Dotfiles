{ pkgs, ... }:

let
  waydroidctl = pkgs.writeShellApplication {
    name = "waydroidctl";
    runtimeInputs = with pkgs; [ coreutils systemd ];
    text = ''
      if [ "$(id -u)" -eq 0 ]; then
        echo "[ERROR] waydroidctl must be run as your user (sudo is used internally for the container)." >&2
        exit 1
      fi

      cmd=''${1:-}
      case "$cmd" in
        up)
          echo "[INFO] Starting Waydroid container"
          sudo ${pkgs.systemd}/bin/systemctl start waydroid-container
          echo "[INFO] Starting Waydroid session"
          systemctl --user start waydroid-session
          echo "[INFO] Waydroid is up."
          ;;
        down)
          echo "[INFO] Stopping Waydroid session"
          systemctl --user stop waydroid-session
          echo "[INFO] Stopping Waydroid container"
          sudo ${pkgs.systemd}/bin/systemctl stop waydroid-container
          echo "[INFO] Waydroid is down."
          ;;
        status)
          container=$(systemctl is-active waydroid-container 2>/dev/null || true)
          session=$(systemctl --user is-active waydroid-session 2>/dev/null || true)
          echo "container: $container"
          echo "session:   $session"
          if [ "$container" != "active" ] || [ "$session" != "active" ]; then
            exit 1
          fi
          ;;
        *)
          echo "Usage: waydroidctl {up|down|status}" >&2
          exit 1
          ;;
      esac
    '';
  };
in
{
  imports = [
    ./frida.nix
  ];

  systemd.user.services.waydroid-session = {
    Unit = {
      Description = "Waydroid User Session";
      After = [ "waydroid-container.service" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.waydroid-nftables}/bin/waydroid session start";
      ExecStop = "${pkgs.waydroid-nftables}/bin/waydroid session stop";

      KillMode = "mixed";

      MemoryMax = "4G";
      MemoryHigh = "3G";

      TimeoutStopSec = "15s";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  home.packages = with pkgs; [
    android-tools
    waydroidctl
  ];
}
