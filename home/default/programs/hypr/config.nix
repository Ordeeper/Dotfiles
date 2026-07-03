{ pkgs, hy3, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3
    ];

    systemd = {
      variables = [ "--all" ];
    };

    settings = {
      general.layout = "hy3";

      monitor = [
        ",preferred,auto,1"
      ];

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
      ];
    };
  };

  home.packages = with pkgs; [
    grimblast
    satty
    wl-clipboard
  ];

  imports = [
    ./keybinds.nix
  ];
}
