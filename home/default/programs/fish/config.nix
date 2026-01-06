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

      # Custom bindings
      bind yy fish_clipboard_copy
      bind p fish_clipboard_paste
      bind -M insert \cF accept-autosuggestion
      bind -M insert \cC self-insert expand-abbr
      bind -M insert ' ' self-insert
    '';
  };
  imports = [
    ./keybinds.nix
  ];
}
