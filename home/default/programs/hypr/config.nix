{ pkgs, ... }:

let
  wallpaper = builtins.toString ./assets/who-am-i.png;
in
{

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        touchpad = {
          natural_scroll = true;
        };
      };

      animations = {
        enabled = true;
      };

      exec-once = [
        "hyprctl setcursor \"Vimix-cursors\" 32"
        "waypaper --restore"
      ];
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  imports = [
    ./keybinds.nix
  ];
}
