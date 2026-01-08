{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
      };

      animations = {
        enabled = true;
      };
    };
  };

  imports = [
    ./keybinds.nix
  ];
}
