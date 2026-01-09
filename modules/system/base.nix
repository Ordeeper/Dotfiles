{ pkgs, ... }:

{
  time.timeZone = "America/Sao_Paulo";

  services.flatpak.enable = true;

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
