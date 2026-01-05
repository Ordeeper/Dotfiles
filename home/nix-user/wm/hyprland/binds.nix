
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "ALT";

    bind = [
      # Terminal
      "ALT, SPACE, exec, kitty"

      # Kill window
      "ALT SHIFT, Q, killactive"

      # Focus (hjkl)
      "ALT, H, movefocus, l"
      "ALT, J, movefocus, d"
      "ALT, K, movefocus, u"
      "ALT, L, movefocus, r"

      # Move window
      "ALT SHIFT, H, movewindow, l"
      "ALT SHIFT, J, movewindow, d"
      "ALT SHIFT, K, movewindow, u"
      "ALT SHIFT, L, movewindow, r"

      # Floating
      "ALT, RETURN, togglefloating"

      # Fullscreen
      "ALT, F, fullscreen"

      # Focus float / tile
      "ALT, TAB, cyclenext"

      # Parent/child (aproximação)
      "ALT, A, focusparent"

      # Scratchpad (special workspace)
      "ALT SHIFT, MINUS, movetoworkspace, special"
      "ALT, MINUS, togglespecialworkspace"

      # Launcher (rofi → wofi)
      "ALT, D, exec, wofi --show drun"

      # Resize mode (aproximação)
      "ALT, R, exec, hyprctl dispatch resizeactive 20 0"
    ];

    # Workspaces
    bind = [
      "ALT, 1, workspace, 1"
      "ALT, 2, workspace, 2"
      "ALT, 3, workspace, 3"
      "ALT, 4, workspace, 4"
      "ALT, 5, workspace, 5"
      "ALT, 6, workspace, 6"
      "ALT, 7, workspace, 7"
      "ALT, 8, workspace, 8"
      "ALT, 9, workspace, 9"
      "ALT, 0, workspace, 10"

      "ALT SHIFT, 1, movetoworkspace, 1"
      "ALT SHIFT, 2, movetoworkspace, 2"
      "ALT SHIFT, 3, movetoworkspace, 3"
      "ALT SHIFT, 4, movetoworkspace, 4"
      "ALT SHIFT, 5, movetoworkspace, 5"
      "ALT SHIFT, 6, movetoworkspace, 6"
      "ALT SHIFT, 7, movetoworkspace, 7"
      "ALT SHIFT, 8, movetoworkspace, 8"
      "ALT SHIFT, 9, movetoworkspace, 9"
      "ALT SHIFT, 0, movetoworkspace, 10"
    ];

    # Media / brightness
    bindel = [
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
      ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];
  };
}
