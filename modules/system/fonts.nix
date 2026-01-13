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
    };
  };
}
