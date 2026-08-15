{ pkgs, config, hy3, ... }:

let
  colors = config.lib.stylix.colors;
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
        "desc:Chimei Innolux Corporation 0x1522,preferred,auto,1"
        "desc:AOC 966W,preferred,auto-center-up,1"
        ",preferred,auto-center-right,1"
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
              active = rgba colors.base01 "ff";
              active_border = rgba colors.base0D "ff";
              active_text = rgba colors.base05 "ff";
              inactive = rgba colors.base01 "ff";
              inactive_border = rgba colors.base03 "01";
              inactive_text = rgba colors.base04 "ff";
              focused = rgba colors.base01 "ff";
              focused_border = rgba colors.base0E "cc";
              focused_text = rgba colors.base05 "ff";
              urgent = rgba colors.base08 "ff";
              urgent_border = rgba colors.base08 "ff";
              urgent_text = rgba colors.base01 "ff";
              locked = rgba colors.base0C "cc";
              locked_border = rgba colors.base0C "ee";
              locked_text = rgba colors.base01 "ff";
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
