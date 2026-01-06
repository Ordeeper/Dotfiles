{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    mouse = true;
    historyLimit = 30000;
    escapeTime = 0;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    focusEvents = true;

    prefix = "C-Space";

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      prefix-highlight
      continuum
    ];

    ## ===== Extra config (literal tmux.conf) =====
    extraConfig = ''
      ##### Misc options
      set -g display-time 1000
      set -g status-interval 5
      set -g set-titles on
      set -s escape-time 0
      set -g set-titles-string "#S / #W"

      ##### Style / Theme
      set -g window-status-current-style "underscore,bold"

      ##### Plugins config
      set -g @resurrect-capture-pane-contents "on"
    '';
  };

  imports = [
    ./keybinds.nix
  ];
}

