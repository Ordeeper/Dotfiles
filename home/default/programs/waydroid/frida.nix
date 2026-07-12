{ pkgs, ... }:

let
  version = "16.7.19";
  arch = "android-x86_64";

  frida-server-archive = pkgs.fetchurl {
    url = "https://github.com/frida/frida/releases/download/${version}/frida-server-${version}-${arch}.xz";
    hash = "sha256-S8k42yfL4f7IWeKPa9NNJpmVpxneLxDpfijBvc2UFsc=";
  };

  frida-server = pkgs.runCommand "frida-server-${version}" {
    nativeBuildInputs = [ pkgs.xz ];
  } ''
    unxz -c ${frida-server-archive} > $out
    chmod +x $out
  '';

  waydroid-frida = pkgs.writeShellApplication {
    name = "waydroid-frida";
    runtimeInputs = with pkgs; [ android-tools coreutils gawk gnused ];
    text = ''
      remote=/data/local/tmp/frida-server

      has_device() {
        adb devices | awk 'NR>1 && $2=="device" { found=1 } END { exit !found }'
      }

      waydroid_ip() {
        waydroid status 2>/dev/null \
          | sed -n 's/^IP address:[[:space:]]*//p' \
          | tr -d '[:space:]'
      }

      check_device() {
        if has_device; then return; fi
        ip=$(waydroid_ip)
        if [ -z "$ip" ]; then
          echo "[ERROR] Could not read Waydroid IP. Is the session running?" >&2
          exit 1
        fi
        adb connect "$ip:5555" >/dev/null 2>&1 || true
        if ! timeout 5 adb -s "$ip:5555" wait-for-device 2>/dev/null; then
          echo "[ERROR] No adb device at $ip:5555 after 5s." >&2
          exit 1
        fi
      }

      frida_pid() {
        adb shell "pidof frida-server" 2>/dev/null | tr -d '\r\n'
      }

      cmd_setup() {
        echo "[INFO] Pushing frida-server ${version} to $remote"
        adb push ${frida-server} "$remote"
        adb shell "su -c 'chmod 755 $remote'"
        echo "[INFO] Setup done."
      }

      cmd_start() {
        if [ -n "$(frida_pid)" ]; then
          echo "[INFO] frida-server already running."
          return
        fi
        echo "[INFO] Starting frida-server"
        adb shell "su -c 'nohup $remote >/dev/null 2>&1 &'"
        for _ in {1..10}; do
          if [ -n "$(frida_pid)" ]; then
            echo "[INFO] frida-server started."
            return
          fi
          sleep 0.2
        done
        echo "[ERROR] frida-server failed to start. Is the image rooted?" >&2
        exit 1
      }

      cmd_stop() {
        if [ -z "$(frida_pid)" ]; then
          echo "[INFO] frida-server not running."
          return
        fi
        adb shell "su -c 'killall frida-server'"
        echo "[INFO] frida-server stopped."
      }

      cmd_status() {
        pid=$(frida_pid)
        if [ -n "$pid" ]; then
          echo "running (PID $pid)"
        else
          echo "stopped"
          exit 1
        fi
      }

      cmd=''${1:-}
      case "$cmd" in
        setup|start|stop|status)
          check_device
          "cmd_$cmd"
          ;;
        *)
          echo "Usage: waydroid-frida {setup|start|stop|status}" >&2
          exit 1
          ;;
      esac
    '';
  };
in
{
  home.packages = with pkgs; [
    frida-tools
    waydroid-frida
  ];
}
