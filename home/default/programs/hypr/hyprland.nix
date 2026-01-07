{
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
      
      misc.focus_on_activate = true;
    };
  };

  imports = [
    ./keybinds.nix
  ];
}
