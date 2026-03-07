{ pkgs, ... }:

{
    systemd.user.services.nwg-panel = {
      Unit = {
        Description = "nwg-panel";
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.nwg-panel}/bin/nwg-panel";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    xdg.configFile."nwg-panel/config".source = ./nwg-panel/config;

    home.packages = with pkgs; [
      nwg-panel
      swaynotificationcenter
    ];
}
