{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    htop
    ripgrep
    fd
  ];

  services.openssh.enable = true;
}
