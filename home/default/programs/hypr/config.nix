{ pkgs, ... }:

let
  wallpaper = builtins.toString ./assets/who-am-i.png;
in
{

  services.swww.enable = true;

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

      exec-once = [
        "hyprctl setcursor \"Vimix-cursors\" 32"
        "swww img ${wallpaper} --transition-type fade"
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
