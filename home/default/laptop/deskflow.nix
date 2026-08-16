{ pkgs, lib, osConfig, ... }:

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
    checkPeerFingerprints=true

    [server]
    externalConfig=true
    externalConfigFile=${topology}
  '';

  trustedClientFingerprints = [ ];

  trustedClientsFile = pkgs.writeText "deskflow-trusted-clients" (
    lib.concatMapStringsSep "\n" (fp: "v2:sha256:${fp}") trustedClientFingerprints
  );

  certSetup = pkgs.writeShellScript "deskflow-tls-setup" ''
    umask 077
    cert="$HOME/.config/deskflow-nix/tls/deskflow.pem"
    if [ ! -f "$cert" ]; then
      dir="$(${pkgs.coreutils}/bin/dirname "$cert")"
      ${pkgs.coreutils}/bin/mkdir -p "$dir"
      ${pkgs.coreutils}/bin/chmod 700 "$dir"
      key=$(${pkgs.coreutils}/bin/mktemp -p "$dir")
      crt=$(${pkgs.coreutils}/bin/mktemp -p "$dir")
      ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
        -subj "/CN=Deskflow" -keyout "$key" -out "$crt"
      ${pkgs.coreutils}/bin/cat "$key" "$crt" > "$cert"
      ${pkgs.coreutils}/bin/rm -f "$key" "$crt"
      ${pkgs.coreutils}/bin/chmod 600 "$cert"
    fi
  '';

  fingerprintCmd = pkgs.writeShellScriptBin "deskflow-fingerprint" ''
    cert="$HOME/.config/deskflow-nix/tls/deskflow.pem"
    if [ ! -f "$cert" ]; then
      echo "no cert yet at $cert -- start/restart the deskflow service first" >&2
      exit 1
    fi
    ${pkgs.openssl}/bin/openssl x509 -in "$cert" -noout -fingerprint -sha256 \
      | sed 's/.*=//; s/://g' | tr 'A-F' 'a-f'
  '';
in
{
  home.packages = [ pkgs.deskflow fingerprintCmd ];

  systemd.user.services.deskflow = {
    Unit = {
      Description = "Deskflow Server Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStartPre = [
        "${pkgs.coreutils}/bin/install -Dm600 ${settingsTemplate} %h/.config/deskflow-nix/settings.ini"
        "${pkgs.coreutils}/bin/install -Dm600 ${trustedClientsFile} %h/.config/deskflow-nix/tls/trusted-clients"
        "${certSetup}"
      ];
      ExecStart = "${pkgs.deskflow}/bin/deskflow-core server -s %h/.config/deskflow-nix/settings.ini";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
