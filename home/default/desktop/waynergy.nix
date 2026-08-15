{ pkgs, osConfig, ... }:

let
  certSetup = pkgs.writeShellScript "waynergy-tls-setup" ''
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
in
{
  home.packages = [ pkgs.waynergy ];

  systemd.user.services.waynergy = {
    Unit = {
      Description = "Waynergy Client Daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStartPre = "${certSetup}";
      ExecStart = "${pkgs.waynergy}/bin/waynergy -c laptop.local -p ${toString osConfig.myLan.deskflowPort} -N desktop -e -t";
      Restart = "always";
      RestartSec = 2;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
