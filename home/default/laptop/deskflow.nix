{ pkgs, lib, osConfig, ... }:

let
  builtinWidth = 1920;
  sideWidth = 1920;
  builtinEnd = builtinWidth * 100 / (builtinWidth + sideWidth);

  topology = pkgs.writeText "deskflow-server.conf" ''
    section: screens
        desktop:
        laptop:
    end

    section: links
      laptop:
        up(0,${toString builtinEnd}) = desktop
      desktop:
        down = laptop(0,${toString builtinEnd})
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
    wlClipboard=true

    [security]
    tlsEnabled=true
    checkPeerFingerprints=true

    [server]
    externalConfig=true
    externalConfigFile=${topology}
  '';

  trustedClientFingerprints = [
    "efde2f8a5b2b07a2038892f514423349cbaea4ce6dbb7f75d89536c20abfa6fb"
  ];

  trustedClientsFile = pkgs.writeText "deskflow-trusted-clients" (
    lib.concatMapStringsSep "\n" (fp: "v2:sha256:${fp}") trustedClientFingerprints
  );

  certSetup = pkgs.writeShellScript "deskflow-tls-setup" ''
    set -euo pipefail
    umask 077
    cert="$HOME/.config/deskflow-nix/tls/deskflow.pem"
    dir="$(${pkgs.coreutils}/bin/dirname "$cert")"
    ${pkgs.coreutils}/bin/mkdir -p "$dir"
    ${pkgs.coreutils}/bin/chmod 700 "$dir"
    if [ ! -s "$cert" ]; then
      key=$(${pkgs.coreutils}/bin/mktemp -p "$dir")
      crt=$(${pkgs.coreutils}/bin/mktemp -p "$dir")
      tmp=$(${pkgs.coreutils}/bin/mktemp -p "$dir")
      trap '${pkgs.coreutils}/bin/rm -f "$key" "$crt" "$tmp"' EXIT
      ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
        -subj "/CN=Deskflow" -keyout "$key" -out "$crt"
      ${pkgs.coreutils}/bin/cat "$key" "$crt" > "$tmp"
      ${pkgs.openssl}/bin/openssl x509 -in "$tmp" -noout
      ${pkgs.openssl}/bin/openssl pkey -in "$tmp" -noout
      ${pkgs.coreutils}/bin/chmod 600 "$tmp"
      ${pkgs.coreutils}/bin/mv -f "$tmp" "$cert"
    fi
  '';

  fingerprintCmd = pkgs.writeShellScriptBin "deskflow-fingerprint" ''
    set -euo pipefail
    cert="$HOME/.config/deskflow-nix/tls/deskflow.pem"
    if [ ! -s "$cert" ]; then
      echo "no cert yet at $cert -- start/restart the deskflow service first" >&2
      exit 1
    fi
    ${pkgs.openssl}/bin/openssl x509 -in "$cert" -noout -fingerprint -sha256 \
      | ${pkgs.gnused}/bin/sed 's/.*=//; s/://g' | ${pkgs.coreutils}/bin/tr 'A-F' 'a-f'
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
      LimitNOFILE = 65536;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
