{
services.vicinae = {
  enable = true;
  systemd = {
    enable = true;
    autoStart = true; # default: false
    environment = {
      USE_LAYER_SHELL = 1;
    };
  };
  settings = {
    close_on_focus_loss = false;
    consider_preedit = true;
    pop_to_root_on_close = true;
    favicon_service = "twenty";
    search_files_in_root = true;
    font = {
      normal = {
        size = 12;
        normal = "Maple Mono NF";
      };
    };
    theme = {
      dark = {
        name = "catppuccin-mocha";
        icon_theme = "default";
      };
    };
    launcher_window = {
      opacity = 1;
    };
  };
  # extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
  #    bluetooth
  #    nix
  #    power-profile
  #   # Extension names can be found in the link below, it's just the folder names
  # ];
};
}
