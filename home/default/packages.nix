{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chromium
    telegram-desktop
    firefox
  ];
}
