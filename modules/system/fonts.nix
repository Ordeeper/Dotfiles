{ pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      antialias = true;

      defaultFonts = {
        sansSerif = [ "Inter" ];
        monospace = [ "Maple Mono NF" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      maple-mono.NF
      noto-fonts
      noto-fonts-color-emoji
      inter
    ];
  };
}
