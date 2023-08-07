if status is-interactive
    # Commands to run in interactive sessions can go here

    # Import colorscheme from 'wal' asynchronously
    cat ~/.cache/wal/sequences &

    # Add components to $fish_user_paths
    fish_add_path -g $HOME/.local/bin

    # Hide the fish greeting
    set -g fish_greeting

    # Enable vi mode
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block
    set -g fish_vi_force_cursor 1

    # Default editor
    set -gx EDITOR nvim

    # Custom bindings
    bind -M insert \cF accept-autosuggestion

    # Abbreviations
    abbr -a tb taskbook

    # Startup
    if not set -q TMUX
        exec tmux
    end
end
