{ username ? "nix-user", ... }:

{
  home.username = username;
  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./programs/hypr/config.nix
    ./programs/kitty/config.nix
    ./programs/git/config.nix
    ./programs/fish/config.nix
    ./programs/tmux/config.nix
    ./programs/zed/config.nix
    ./programs/vicinae/config.nix
    ./programs/waybar/config.nix
    ./programs/xdg/config.nix
    ./programs/mise/config.nix
    ./programs/direnv/config.nix

    ./packages.nix
  ];
}
