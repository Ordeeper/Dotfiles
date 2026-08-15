{ pkgs, osConfig, ... }:

let
  topology = pkgs.writeText "deskflow-server.conf" ''
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

  settingsTemplate = pkgs.writeText "deskflow-settings.ini" ''
    [core]
    screenName=laptop
    port=${toString osConfig.myLan.deskflowPort}

    [security]
    tlsEnabled=true
    checkPeerFingerprints=false

    [server]
    externalConfig=true
    externalConfigFile=${topology}
  '';
in
{
  home.packages = [ pkgs.deskflow ];

  systemd.user.services.deskflow = {
    Unit = {
      Description = "Deskflow Server Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/install -Dm600 ${settingsTemplate} %h/.config/deskflow-nix/settings.ini";
      ExecStart = "${pkgs.deskflow}/bin/deskflow-core server -s %h/.config/deskflow-nix/settings.ini";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
