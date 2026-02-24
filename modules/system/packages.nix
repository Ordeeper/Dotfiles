{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    htop
    ripgrep
    fd
    tldr
    gnumake
  ];
}
