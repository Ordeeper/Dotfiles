{ pkgs, osConfig, ... }:

let
  host = osConfig.networking.hostName;
  isDesktop = host == "desktop";
in
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

    xdg.configFile."nwg-panel/config".source =
    if isDesktop then
    ./nwg-panel/desktop
    else
    ./nwg-panel/laptop;

    home.packages = with pkgs; [
      nwg-panel
      swaynotificationcenter
      (if isDesktop then ddcutil else brightnessctl)
    ];
}
