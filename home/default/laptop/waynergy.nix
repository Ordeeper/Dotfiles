{ pkgs, ... }:

{
  home.packages = [ pkgs.waynergy ];

  systemd.user.services.waynergy = {
    Unit = {
      Description = "Waynergy Client Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waynergy}/bin/waynergy -c 192.168.0.24 -p 24800";
      Restart = "always";
      RestartSec = 2;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
