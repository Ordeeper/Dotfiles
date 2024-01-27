if status is-interactive
    # Commands to run in interactive sessions can go here

    # Import colorscheme from 'wal' asynchronously
    cat ~/.cache/wal/sequences &

    # Add components to $fish_user_paths
    fish_add_path -g $HOME/.local/bin $HOME/.cargo/bin

    # Hide the fish greeting
    set -g fish_greeting

    # Misc
    set -gx EDITOR nvim

    # Enable vi mode
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

    # Abbreviations
    # abbr -a cava TERM=xterm-kitty cava

    # Startup
    if not set -q TMUX
        exec tmux
        printf '\ec'
    else
        printf '\ec'
    end

end
