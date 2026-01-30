{ config, pkgs, ... }:

let
  catppuccinMochaScheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
in
{
  stylix = {
    enable = true;
    base16Scheme = catppuccinMochaScheme;
    polarity = "dark";

    targets = {
      zed.enable = false;
    };

    cursor = {
      package = pkgs.vimix-cursors;
      name = "Vimix-cursors";
      size = 32;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    autoEnable = true;
  };
}
