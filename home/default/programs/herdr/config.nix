{ pkgs, inputs, ... }:

let
  herdr = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;

  balance = pkgs.writeShellScriptBin "herdr-balance" ''
    exec ${pkgs.python3}/bin/python3 ${./balance.py} "$@"
  '';

  sessionPicker = pkgs.writeShellApplication {
    name = "herdr-session-picker";
    runtimeInputs = [ herdr pkgs.fzf pkgs.python3 pkgs.gawk pkgs.gnugrep pkgs.gnused pkgs.coreutils ];
    text = builtins.readFile ./session-picker.sh;
  };

  sessionLoop = pkgs.writeShellApplication {
    name = "herdr-session-loop";
    runtimeInputs = [ herdr sessionPicker pkgs.coreutils ];
    text = builtins.readFile ./session-loop.sh;
  };
in
{
  home.packages = [
    herdr
    balance
    sessionPicker
    sessionLoop
  ];

  xdg.configFile."herdr/config.toml".text = ''
    onboarding = false

    [theme]
    name = "catppuccin"

    [theme.custom]
    accent = "#b4befe"

    [ui]
    prompt_new_tab_name = false

    [keys]
    prefix = "ctrl+space"
    detach = "prefix+d"
    new_tab = "prefix+space"
    next_tab = "prefix+tab"
    previous_tab = "prefix+shift+tab"
    open_notification_target = "prefix+a"
    close_tab = "prefix+shift+q"
    close_pane = "prefix+q"
    zoom = "prefix+f"
    toggle_sidebar = "prefix+b"
    split_vertical = "prefix+n"
    split_horizontal = "prefix+m"

    [[keys.command]]
    key = "prefix+z"
    type = "shell"
    description = "Even out pane sizes"
    command = "${balance}/bin/herdr-balance"
  '';
}
