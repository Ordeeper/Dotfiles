{ pkgs, config, hy3, ... }:

let
  colors = config.lib.stylix.colors;
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
in
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

      plugin = {
        hy3 = {
          node_collapse_policy = 0;
          tabs = {
            from_top = true;
            border_width = 1;
            radius = 6;
            text_font = config.stylix.fonts.monospace.name;
            text_height = config.stylix.fonts.sizes.desktop;
            colors = {
              active = rgba colors.base0D "40";
              active_border = rgba colors.base0D "ee";
              active_text = rgba colors.base05 "ff";
              inactive = rgba colors.base01 "20";
              inactive_border = rgba colors.base03 "aa";
              inactive_text = rgba colors.base05 "ff";
              focused = rgba colors.base03 "40";
              focused_border = rgba colors.base03 "ee";
              focused_text = rgba colors.base05 "ff";
              urgent = rgba colors.base08 "40";
              urgent_border = rgba colors.base08 "ee";
              urgent_text = rgba colors.base05 "ff";
              locked = rgba colors.base0C "40";
              locked_border = rgba colors.base0C "ee";
              locked_text = rgba colors.base05 "ff";
            };
          };
        };
      };
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
