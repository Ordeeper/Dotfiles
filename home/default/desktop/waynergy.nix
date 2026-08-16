{ pkgs, lib, osConfig, ... }:

let
  trustedServerFingerprint = "4b3748af9e2288aca0f7c33f3aebd9e3f4cc65dd171f0b4043603adc0d3df1c8";

  serverHashFile = pkgs.writeText "waynergy-server-hash" "SHA256:${trustedServerFingerprint}";

  certSetup = pkgs.writeShellScript "waynergy-tls-setup" ''
    umask 077
    cert="$HOME/.config/waynergy/tls/cert"
    if [ ! -f "$cert" ]; then
      ${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$cert")"
      key=$(${pkgs.coreutils}/bin/mktemp)
      crt=$(${pkgs.coreutils}/bin/mktemp)
      ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
        -subj "/CN=waynergy-desktop" -keyout "$key" -out "$crt"
      ${pkgs.coreutils}/bin/cat "$key" "$crt" > "$cert"
      ${pkgs.coreutils}/bin/rm -f "$key" "$crt"
      ${pkgs.coreutils}/bin/chmod 600 "$cert"
    fi
  '';

  fingerprintCmd = pkgs.writeShellScriptBin "waynergy-fingerprint" ''
    cert="$HOME/.config/waynergy/tls/cert"
    if [ ! -f "$cert" ]; then
      echo "no cert yet at $cert -- start/restart the waynergy service first" >&2
      exit 1
    fi
    ${pkgs.openssl}/bin/openssl x509 -in "$cert" -noout -fingerprint -sha256 \
      | sed 's/.*=//; s/://g' | tr 'A-F' 'a-f'
  '';
in
{
  home.packages = [ pkgs.waynergy fingerprintCmd ];

  systemd.user.services.waynergy = {
    Unit = {
      Description = "Waynergy Client Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStartPre = [ "${certSetup}" ] ++ lib.optional (trustedServerFingerprint != "")
        "${pkgs.coreutils}/bin/install -Dm600 ${serverHashFile} %h/.config/waynergy/tls/hash/laptop.local";
      ExecStart = "${pkgs.waynergy}/bin/waynergy -c laptop.local -p ${toString osConfig.myLan.deskflowPort} -N desktop -e";
      Restart = "always";
      RestartSec = 2;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
