{ config, pkgs, ... }:

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
    };
  };

  systemd.services.waydroid-adb-persistence = {
    description = "Enforce adb-over-TCP port inside Waydroid";
    after = [ "waydroid-container.service" ];
    bindsTo = [ "waydroid-container.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "waydroid-adb-enable" ''
        set -e
        ${pkgs.coreutils}/bin/sleep 5
        ${config.virtualisation.waydroid.package}/bin/waydroid prop set service.adb.tcp.port ${toString adbTcpPort}
      '';
    };
  };
}
