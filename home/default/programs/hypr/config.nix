{ pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      variables = [ "--all" ];
    };

    settings = {
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
        "waypaper --restore"
        "nm-applet --indicator"
      ];
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];

  imports = [
    ./keybinds.nix
  ];
}
