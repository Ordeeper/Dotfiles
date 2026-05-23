{ pkgs, ... }:

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
    php84Packages.composer
    devenv
    converseen
    lmstudio
    openfortivpn
    docker-compose
    p7zip
    gcc
    zotero
    waypaper
    awww
    nwg-displays
    easyeffects
    appimage-run
    burpsuite
    satty
    cloudflared
    caido-desktop
  ];
}
