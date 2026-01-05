{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = {
		kb_layout = "us";
		kb_variant = "intl";
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive"
        "$mod, D, exec, wofi --show drun"
        "$mod, F, togglefloating"
        "$mod, S, togglesplit"
      ];

      animations = {
        enabled = true;
      };
    };
  };
}
