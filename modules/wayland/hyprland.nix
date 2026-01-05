
{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    grim
    slurp
    wl-clipboard
  ];
}
