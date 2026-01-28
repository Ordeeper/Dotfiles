{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Hide greeting
      set -g fish_greeting

      set -gx MOZ_ENABLE_WAYLAND 1
      set -gx EDITOR nvim
      set -gx TERMINAL kitty
      set -gx BROWSER "flatpak run io.github.zen_browser.zen"

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
          and test -t 1
              exec tmux
      end
    '';
  };
  imports = [
    ./keybinds.nix
  ];
}
