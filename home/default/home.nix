{ username ? "nix-user", ... }:

{
  home.username = username;
  home.stateVersion = "25.11";

  programs.neovim.enable = true;

  imports = [
    ./programs/hypr/hyprland.nix
    ./programs/kitty/kitty.nix
    ./programs/git/config.nix
    ./programs/zed/settings.nix
  ];
}
