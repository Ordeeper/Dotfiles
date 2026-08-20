{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "ALT";

    bind = [
  	  # Kill Hyprland
  	  "$mod SHIFT, E, exec, hyprctl dispatch exit"

      # Screenshot
      "$mod SHIFT, S, exec, screenshot-area"

      # Terminal
      "$mod, SPACE, exec, kitty"

      # Kill window
      "$mod SHIFT, Q, hy3:killactive"

      # Lock
      "$mod, apostrophe, exec, dms ipc call lock lock"

      # Workspace Toggle Overview
      "$mod, S, exec, dms ipc call hypr toggleOverview"

      "$mod, W, hy3:changegroup, toggletab"
      "$mod, E, hy3:changegroup, opposite"

      # Focus tabs and windows (no visible flag)
      "$mod, H, hy3:movefocus, l"
      "$mod, J, hy3:movefocus, d"
      "$mod, K, hy3:movefocus, u"
      "$mod, L, hy3:movefocus, r"

      # Focus (hjkl) - skip tabs, go to visible window
      "$mod CTRL, H, hy3:movefocus, l, visible"
      "$mod CTRL, J, hy3:movefocus, d, visible"
      "$mod CTRL, K, hy3:movefocus, u, visible"
      "$mod CTRL, L, hy3:movefocus, r, visible"

      # Focus all windows
      "$mod, A, hy3:changefocus, raise"

      # Split horizontal
      "$mod, N, hy3:makegroup, h"

      # Split vertical
      "$mod, M, hy3:makegroup, v"

      # Move window
      "$mod SHIFT, H, hy3:movewindow, l"
      "$mod SHIFT, J, hy3:movewindow, d"
      "$mod SHIFT, K, hy3:movewindow, u"
      "$mod SHIFT, L, hy3:movewindow, r"

      # Floating
      "$mod, RETURN, togglefloating"

      # Fullscreen
      "$mod, F, fullscreen"

      # Focus next (hy3 tabs)
      "$mod, TAB, hy3:focustab, r, wrap"
      "$mod SHIFT, TAB, hy3:focustab, l, wrap"

      # Scratchpad (special workspace)
      "$mod SHIFT, MINUS, movetoworkspace, special"
      "$mod, MINUS, togglespecialworkspace"

      # Launcher
      "$mod, D, exec, dms ipc call spotlight toggle"
      "$mod, C, exec, dms ipc call clipboard toggle"

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

      "$mod SHIFT, 1, hy3:movetoworkspace, 1"
      "$mod SHIFT, 2, hy3:movetoworkspace, 2"
      "$mod SHIFT, 3, hy3:movetoworkspace, 3"
      "$mod SHIFT, 4, hy3:movetoworkspace, 4"
      "$mod SHIFT, 5, hy3:movetoworkspace, 5"
      "$mod SHIFT, 6, hy3:movetoworkspace, 6"
      "$mod SHIFT, 7, hy3:movetoworkspace, 7"
      "$mod SHIFT, 8, hy3:movetoworkspace, 8"
      "$mod SHIFT, 9, hy3:movetoworkspace, 9"
      "$mod SHIFT, 0, hy3:movetoworkspace, 10"

      "$mod, grave, exec, dms ipc call powermenu toggle"

      ",XF86AudioMute, exec, dms ipc call audio mute"

      "$mod, slash, exec, dms ipc call mpris playPause"
      "$mod, comma, exec, dms ipc call mpris previous"
      "$mod, period, exec, dms ipc call mpris next"

      "$mod, semicolon, exec, dms ipc call notepad toggle"

      "$mod SHIFT, T, exec, toggle-touchpad"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, dms ipc call audio increment 5"
      ",XF86AudioLowerVolume, exec, dms ipc call audio decrement 5"
      ",XF86MonBrightnessUp, exec, dms ipc call brightness increment 5 ''"
      ",XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5 ''"

      "$mod, bracketleft, exec, dms ipc call audio decrement 5"
      "$mod, bracketright, exec, dms ipc call audio increment 5"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = ''
    # Resize mode
    bind = ALT, R, submap, resize

    submap = resize
    binde = , H, resizeactive, -10 0
    binde = , J, resizeactive, 0 10
    binde = , K, resizeactive, 0 -10
    binde = , L, resizeactive, 10 0
    binde = , left, resizeactive, -10 0
    binde = , down, resizeactive, 0 10
    binde = , up, resizeactive, 0 -10
    binde = , right, resizeactive, 10 0
    bind = , escape, submap, reset
    bind = ALT, R, submap, reset
    submap = reset
  '';

  imports = [
    ./scripts/touchpad-toggle.nix
    ./scripts/screenshot-area.nix
  ];
}
