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
    openfortivpn-webview
    btop
    tree
    libinput
    vscodium
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
    inputs.kimi-code.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
