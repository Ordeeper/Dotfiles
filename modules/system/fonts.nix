{ pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
      hinting = "slight";
      antialiasing = true;

      defaultFonts = {
        sansSerif = [ "Inter" ];
        monospace = [ "Maple Mono NF" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      maple-mono.NF;

      noto-fonts
      noto-fonts-emoji

      inter
    ];
  };
}
