{
  programs.tmux.extraConfig = 
     ''
      ##### Vi mode
      set -g status-keys vi

      ##### Unbind default prefix
      unbind C-b
      bind C-Space send-prefix

      ##### Windows
      bind N previous-window
      bind n split-window -h -c "#{pane_current_path}"
      bind m split-window -c "#{pane_current_path}"
      bind Q confirm-before -p "kill-window #W? (y/n)" kill-window
      bind Space new-window -c "#{pane_current_path}"
      bind Tab last-window

      ##### Panes
      bind q kill-pane
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R
      bind -r K resize-pane -U
      bind -r J resize-pane -D
      bind -r H resize-pane -L
      bind -r L resize-pane -R
      bind f resize-pane -Z
      bind -r N swap-pane -U
      bind -r M swap-pane -D

      ##### Copy mode (vi)
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel

      ##### Toggle status bar
      bind -r o set -g status
    '';
}

