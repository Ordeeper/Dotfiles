{ config, lib, pkgs, username ? "nix-user", ... }:

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

  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        { command = "${pkgs.systemd}/bin/systemctl start waydroid-container"; options = [ "NOPASSWD" ]; }
        { command = "${pkgs.systemd}/bin/systemctl stop waydroid-container"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];

  systemd.services.waydroid-container = {
    wantedBy = lib.mkForce [];
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
    wantedBy = [ "waydroid-container.service" ];
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
