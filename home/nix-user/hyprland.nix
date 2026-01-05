{
  imports = [
    ./wm/hyprland/binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "intl";
      };

      animations = {
        enabled = true;
      };
    };
  };
}
