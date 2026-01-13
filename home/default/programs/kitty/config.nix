{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    enableGitIntegration = true;

    settings = {
	cursor_trail = "3";
	cursor_trail_decay = "0.1 0.4";

        confirm_os_window_close = "0";

	inactive_text_alpha = "1.0";

	allow_remote_control = "socket-only";
        listen_on = "unix:@kitty";
        remote_control_password = "\"\" set-colors";
    };

    extraConfig = ''
      modify_font underline_position -2
      modify_font underline_thickness 140%
    '';
  };
}
