{
  programs.fish.interactiveShellInit = ''
    function fish_user_key_bindings
        fish_vi_key_bindings
        bind yy fish_clipboard_copy
        bind p fish_clipboard_paste
        bind -M insert \cF accept-autosuggestion
        bind -M insert \cC self-insert expand-abbr
        bind -M insert ' ' self-insert
    end
  '';
}
