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
    imagemagick
    img2pdf
    tesseract
    zbar
    inputs.kimi-code.packages.${pkgs.system}.default
  ];
}
