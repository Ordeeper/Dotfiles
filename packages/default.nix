{ pkgs, inputs, ... }:

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
    libva-utils
    zotero
    easyeffects
    appimage-run
    burpsuite
    cloudflared
    caido-desktop
    heroic
    anki-bin
    apktool
    (callPackage ./openscreen.nix { })
    inputs.kimi-code.packages.${pkgs.system}.default
  ];
}
