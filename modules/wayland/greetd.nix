{ username ? "nix-user", inputs, hyprland, pkgs, ... }:

{
  services.displayManager.dms-greeter = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
    compositor.name = "hyprland";

    configHome = "/home/${username}";

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  services.dbus.enable = true;

  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
