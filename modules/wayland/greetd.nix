{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "tuigreet --cmd Hyprland";
        user = "nix-user";
      };
    };
  };

  security.pam.services.greetd.enable = true;

  programs.hyprland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };
}
