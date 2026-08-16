{ pkgs, inputs, ... }:

{
  home.packages = [ inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default ];

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
    toggle_sidebar = "prefix+o"
    split_vertical = "prefix+n"
    split_horizontal = "prefix+m"
  '';
}
