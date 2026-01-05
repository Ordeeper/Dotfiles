{ pkgs, ... }:

{
  home.username = "nix-user";
  home.homeDirectory = "/home/nix-user";
  home.stateVersion = "24.11";

  programs.git.enable = true;
  programs.neovim.enable = true;

  imports = [
    ./hyprland.nix
  ];
}

