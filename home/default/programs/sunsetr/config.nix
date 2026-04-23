{ pkgs, ... }:

{
  systemd.user.services.sunsetr = {
    Unit = {
      Description = "Sunsetr Color Temperature Adjuster";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.sunsetr}/bin/sunsetr";
      Restart = "on-failure";
      Type = "simple";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.configFile."sunsetr/sunsetr.toml".source = ./config.toml;

  home.packages = with pkgs; [
    sunsetr
  ];
}
