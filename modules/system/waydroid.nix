{ lib, pkgs, ... }:

let
  adbTcpPort = 5555;
in
{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  systemd.services.waydroid-container = {
    serviceConfig = {
      Delegate = true;
      CPUAccounting = true;
      MemoryAccounting = true;
      TasksAccounting = true;

      ExecStartPre = lib.mkAfter [
        (pkgs.writeShellScript "waydroid-adb-prop-pre" ''
          set -e
          PROP_FILE="/var/lib/waydroid/waydroid.prop"

          mkdir -p /var/lib/waydroid
          touch "$PROP_FILE"
          chown root:root "$PROP_FILE"
          chmod 644 "$PROP_FILE"

          ${pkgs.gnused}/bin/sed -i "/^service.adb.tcp.port=/d" "$PROP_FILE"
          echo "service.adb.tcp.port=${toString adbTcpPort}" >> "$PROP_FILE"
        '')
      ];
    };
  };
}
