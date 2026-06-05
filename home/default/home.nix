{ username ? "nix-user", osConfig, lib, ... }:

let
  host = osConfig.networking.hostName;
  isDesktop = host == "desktop";
  isLaptop  = host == "laptop";
  # isServer  = host == "server";
in
{
  home.username = username;
  home.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./programs/hypr/config.nix
    ./programs/kitty/config.nix
    ./programs/git/config.nix
    ./programs/fish/config.nix
    ./programs/tmux/config.nix
    ./programs/zed/config.nix
    ./programs/vicinae/config.nix
    ./programs/dms/config.nix
    ./programs/xdg/config.nix
    ./programs/mise/config.nix
    ./programs/direnv/config.nix
    ./programs/stylix/config.nix
    ./programs/flatpak/config.nix
    ./programs/opencode/config.nix
    ./programs/nvim/config.nix

    ./session-variables.nix

    ./packages.nix
  ]

  ++ lib.optionals isLaptop [
      ./laptop/waynergy.nix
  ]

  ++ lib.optionals isDesktop [
      ./desktop/deskflow.nix
  ];
}
