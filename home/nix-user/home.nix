{ pkgs, ... }:

{
  home.username = "joe";
  home.homeDirectory = "/home/nix-user";
  home.stateVersion = "24.11";

  programs.git.enable = true;
  programs.neovim.enable = true;

  imports = [
    ./hyprland.nix
  ];
}

