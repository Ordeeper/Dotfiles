{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.file."Pictures" = {
    source = ./pictures;
    recursive = true;
  };
}
