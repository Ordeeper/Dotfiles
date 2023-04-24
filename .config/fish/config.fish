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

    # Default editor
    set -gx EDITOR nvim

    # Custom bindings
    bind -M insert \cF accept-autosuggestion

    # Abbreviations
    abbr -a tb taskbook

end
