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
              active = rgba colors.base02 "ff";
              active_border = rgba colors.base0D "ff";
              active_text = rgba colors.base05 "ff";
              inactive = rgba colors.base01 "ff";
              inactive_border = rgba colors.base03 "aa";
              inactive_text = rgba colors.base05 "ff";
              focused = rgba colors.base02 "cc";
              focused_border = rgba colors.base0D "cc";
              focused_text = rgba colors.base05 "ff";
              urgent = rgba colors.base08 "ff";
              urgent_border = rgba colors.base08 "ff";
              urgent_text = rgba colors.base05 "ff";
              locked = rgba colors.base0C "cc";
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
