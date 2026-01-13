{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    chromium
    telegram-desktop
    firefox
    obsidian
    dropbox
    hoppscotch
    mpv
    nemo
    grim
    satty
    slurp
    php84Packages.composer
    kdePackages.gwenview
    devenv
    converseen
    lmstudio
    openfortivpn
  ];
}
