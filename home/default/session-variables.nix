{
  systemd.user.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];

}
