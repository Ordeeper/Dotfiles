{ username ? "nix-user", osConfig, lib, ... }:

let
  host = osConfig.networking.hostName;
  isDesktop = host == "desktop";
  isLaptop  = host == "laptop";
in
{
  home.username = username;
  home.stateVersion = "26.05";

  imports = [
    ./programs/hypr/config.nix
    ./programs/kitty/config.nix
    ./programs/git/config.nix
    ./programs/fish/config.nix
    ./programs/herdr/config.nix
    ./programs/zed/config.nix
    ./programs/dms/config.nix
    ./programs/dsearch/config.nix
    ./programs/xdg/config.nix
    ./programs/mise/config.nix
    ./programs/direnv/config.nix
    ./programs/stylix/config.nix
    ./programs/flatpak/config.nix
    ./programs/opencode/config.nix
    ./programs/claude-code/config.nix
    ./programs/nvim/config.nix
    ./programs/waydroid/config.nix

    ./session-variables.nix

    ../../packages
  ]
  ++ lib.optionals isLaptop [
    ./laptop/deskflow.nix
  ]
  ++ lib.optionals isDesktop [
    ./desktop/waynergy.nix
  ];
}
