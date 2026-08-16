{ config, ... }:

{
  programs.dsearch = {
    enable = true;

    config = {
      index_paths = [
        {
          path = config.home.homeDirectory;
          max_depth = 0;
          exclude_hidden = true;
          exclude_dirs = [
            "node_modules"
            ".cache"
            ".git"
            ".cargo"
            ".rustup"
            "Trash"
          ];
        }
      ];
    };
  };
}
