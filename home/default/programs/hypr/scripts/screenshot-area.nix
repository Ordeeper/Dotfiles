{ pkgs, ... }:

let
  screenshot-area = pkgs.writeShellApplication {
    name = "screenshot-area";
    runtimeInputs = with pkgs; [ grimblast satty wl-clipboard coreutils ];
    text = builtins.readFile ./screenshot-area.sh;
  };
in
{
  home.packages = [ screenshot-area ];
}
