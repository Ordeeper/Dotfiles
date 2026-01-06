{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Hide greeting
      set -g fish_greeting

      # Vi mode + cursor shapes
      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block
      set -g fish_vi_force_cursor 1

      if status is-interactive
        and not set -q TMUX
	and command -v tmux >/dev/null
	  exec tmux
      end
    '';
  };
  imports = [
    ./keybinds.nix
  ];
}
