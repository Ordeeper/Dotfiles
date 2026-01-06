{ pkgs, username ? "nix-user", ... }:

{
  home.username = username;
  home.stateVersion = "25.11";

  programs.neovim.enable = true;
  programs.git = {
    enable = true;
    userName = "Ordeeper";
    userEmail = "pedrordeeper@gmail.com";
    extraConfig = {
      init = {defaultBranch = "main";};
    };
  };

  imports = [
    ./programs/hypr/hyprland.nix
  ];
}
