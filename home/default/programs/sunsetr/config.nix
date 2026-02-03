{ pkgs, ... }:

{
  systemd.user.services.sunsetr = {
    Unit = {
      Description = "Sunsetr Color Temperature Adjuster";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.sunsetr}/bin/sunsetr";
      Restart = "on-failure";
      Type = "simple";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.file."~/.config/sunsetr/config.toml".source = ./config.toml;

  home.packages = with pkgs; [
    sunsetr
  ];

}
