{ username ? "nix-user", ... }:

{
  home.username = username;
  home.stateVersion = "25.11";

  imports = [
    ./programs/hypr/hyprland.nix
    ./programs/kitty/kitty.nix
    ./programs/git/config.nix
    ./programs/fish/config.nix
    ./programs/tmux/tmux.nix
    ./programs/zed/settings.nix
    ./programs/vicinae/settings.nix
    ./programs/waybar/config.nix
    ./programs/xdg/config.nix

    ./packages.nix

    ./session.nix
  ];
}
