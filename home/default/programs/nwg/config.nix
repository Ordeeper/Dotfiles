{ pkgs, ... }:

let
    nwg = pkgs.nwg-panel;
in
{
    systemd.user.services.nwg-panel = {
        Unit.After = [ "graphical-session.target" ];
        Service.ExecStart = "${nwg}/bin/nwg-panel";
        Install.WantedBy = [ "graphical-session.target" ];
    };

    xdg.configFile."nwg-panel/config".source = ./nwg-panel/config;

    home.packages = [ nwg ];
}
