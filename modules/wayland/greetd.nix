{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/start-hyprland";
        user = "nix-user";
      };
    };
  };

  services.dbus.enable = true;
  security.pam.services.greetd.enable = true;

  programs.hyprland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };
}
