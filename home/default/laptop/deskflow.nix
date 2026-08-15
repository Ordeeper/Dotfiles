{ pkgs, ... }:

let
  # Old synergy/barrier text format. deskflow-core only reads this via
  # server/externalConfigFile, never writes to it, so a plain Nix store path
  # is fine here.
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

  # deskflow-core rewrites its settings file in place (state like
  # core/startedBefore), so it can't be a home.file symlink into the Nix
  # store. ExecStartPre reseeds it from this template on every start; the TLS
  # trust database lives in a separate tls/ directory next to it and survives
  # the reseed.
  #
  # checkPeerFingerprints is deliberately off, not just left at its default:
  # turning it on sets the server's SecurityLevel to PeerAuth, which rejects
  # any client whose cert isn't already in tls/trustedClients -- and nothing
  # ever adds to that file outside the GUI (SecureSocket::verifyCertFingerprint
  # only reads it). Headless, that means every connection is refused forever.
  # waynergy's own TOFU (-t) already covers this link's actual threat model:
  # it pins and verifies the server's cert on first connect, so a spoofed
  # laptop.local answer can't complete a handshake after that point.
  settingsTemplate = pkgs.writeText "deskflow-settings.ini" ''
    [core]
    screenName=laptop
    port=24800

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
      # deskflow-core (not the deskflow GUI binary) is the headless daemon.
      # -s points at the settings ini above, not the screen topology, which
      # is set inside that ini via server/externalConfigFile.
      ExecStart = "${pkgs.deskflow}/bin/deskflow-core server -s %h/.config/deskflow-nix/settings.ini";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
