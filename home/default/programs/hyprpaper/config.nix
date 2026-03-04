let
  wallpaper = ../../assets/who-am-i.png;
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [ wallpaper ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };
}
