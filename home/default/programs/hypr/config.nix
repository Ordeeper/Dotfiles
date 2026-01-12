{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
      };

      animations = {
        enabled = true;
      };
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
  ]; 
  
  imports = [
    ./keybinds.nix
  ];
}
