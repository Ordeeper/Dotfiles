{ pkgs, ... }:
{
  home.packages = [ pkgs.deskflow ];

  home.file.".config/deskflow/deskflow.conf".text = ''
    section: screens
        desktop:
        laptop:
    end

    section: links
      laptop:
        right = desktop
      desktop:
        left = laptop
    end

    section: options
        clipboardSharing = true
        switchCorners = none
        switchCornerSize = 0
    end
  '';

  systemd.user.services.deskflow = {
    Unit = {
      Description = "Deskflow Server Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.deskflow}/bin/deskflow --server --address 0.0.0.0:24800 --config %h/.config/deskflow/deskflow.conf";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
