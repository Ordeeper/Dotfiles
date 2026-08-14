{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/base.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/sound.nix
    ../../modules/system/fonts.nix
    ../../modules/system/packages.nix
    ../../modules/system/nix.nix
    ../../modules/system/boot.nix
    ../../modules/system/zram.nix
    ../../modules/system/memory.nix
    ../../modules/system/journald.nix
    ../../modules/system/security.nix
    ../../modules/system/printer.nix
    ../../modules/system/gaming.nix
    ../../modules/system/input/keyd.nix
    ../../modules/system/waydroid.nix

    ../../modules/wayland/greetd.nix

    ../../modules/desktop/udev.nix
    ../../modules/desktop/graphics.nix
    ../../modules/desktop/ollama.nix
    ../../modules/desktop/performance.nix
  ];

  networking.hostName = "desktop";
}
