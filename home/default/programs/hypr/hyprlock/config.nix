{
  programs.hyprlock = {
    enable = true;

    settings = {
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 72;
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
