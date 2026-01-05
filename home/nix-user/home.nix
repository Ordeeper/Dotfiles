{ pkgs, ... }:

{
  home.username = "nix-user";
  home.homeDirectory = "/home/nix-user";
  home.stateVersion = "24.11";

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
    ./hyprland.nix
	./apps/terminals/kitty.nix
  ];
}
