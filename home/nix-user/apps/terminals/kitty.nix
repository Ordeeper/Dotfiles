{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      background_opacity = "0.90";
    };
  };
}
