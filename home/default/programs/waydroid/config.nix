{ pkgs, ... }:
{
  systemd.user.services.waydroid-session = {
    Unit = {
      Description = "Waydroid User Session";
      After = [ "waydroid-container.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
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
    };
  };

  home.packages = with pkgs; [
    android-tools
  ];
}
