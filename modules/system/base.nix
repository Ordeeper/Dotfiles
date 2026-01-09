{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    htop
    ripgrep
    fd
  ];

  services.openssh.enable = true;
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;

    config.common = {
        default = [
          "hyprland"
          "gtk"
        ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}
