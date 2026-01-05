{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/base.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/nix.nix
    ../../modules/system/input/keyd.nix

    ../../modules/wayland/hyprland.nix
    ../../modules/wayland/greetd.nix
  ];

  networking.hostName = "desktop";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nix-user = import ../../home/nix-user/home.nix;
  };
}
