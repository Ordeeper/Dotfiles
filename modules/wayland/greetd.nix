{ username ? "nix-user", ... }:

{
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";

    configHome = "/home/${username}";

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  services.dbus.enable = true;

  programs.hyprland.enable = true;
}
