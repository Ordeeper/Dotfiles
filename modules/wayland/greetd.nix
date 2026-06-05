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
  security.pam.services.greetd.enable = true;

  programs.hyprland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };
}
