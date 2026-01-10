{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "ALT";

    bind = [
  	  # Kill Hyprland
  	  "$mod SHIFT, E, exec, hyprctl dispatch exit"

      # Screenshot
      "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | satty --filename -"

      # Terminal
      "$mod, SPACE, exec, kitty"

      # Kill window
      "$mod SHIFT, Q, killactive"

      # Focus (hjkl)
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      # Move window
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"

      # Floating
      "$mod, RETURN, togglefloating"

      # Fullscreen
      "$mod, F, fullscreen"

      # Focus next
      "$mod, TAB, cyclenext"

      # Scratchpad (special workspace)
      "$mod SHIFT, MINUS, movetoworkspace, special"
      "$mod, MINUS, togglespecialworkspace"

      # Launcher
      "$mod, D, exec, vicinae toggle"
      "$mod, C, exec, vicinae vicinae://extensions/vicinae/clipboard/history"

      # Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +10%"
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -10%"
      ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];

  };
}
