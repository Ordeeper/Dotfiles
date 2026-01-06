{
  programs.fish.interactiveShellInit = ''
    bind yy fish_clipboard_copy
    bind p fish_clipboard_paste
    bind -M insert \cF accept-autosuggestion
    bind -M insert \cC self-insert expand-abbr
    bind -M insert ' ' self-insert
  '';
}

