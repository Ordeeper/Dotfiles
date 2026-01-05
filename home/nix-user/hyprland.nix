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
    };
	imports = [
		./wm/hyprland/binds.nix
	];
  };
}
