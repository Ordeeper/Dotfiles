{ pkgs, ... }:

{
  services.flatpak.enable = true;
  virtualisation.docker.enable = true;

  system.stateVersion = "26.05";

  xdg.portal = {
    enable = true;

    config.common = {
      default = [
        "hyprland"
        "gtk"
        "kde"
      ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };
}
