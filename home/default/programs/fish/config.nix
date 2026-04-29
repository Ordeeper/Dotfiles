{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if status is-interactive
          # Hide greeting
          set -g fish_greeting

          # Vi mode + cursor shapes
          fish_vi_key_bindings
          set fish_cursor_default block
          set fish_cursor_insert line
          set fish_cursor_replace_one underscore
          set fish_cursor_visual block
          set -g fish_vi_force_cursor 1

          if not set -q TMUX; and command -v tmux >/dev/null; and test -t 1
              exec tmux
          end
      end
    '';
  };

  imports = [
    ./keybinds.nix
  ];
}
