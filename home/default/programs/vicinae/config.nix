{ ... }:

{
  programs.vicinae = {
    enable = true;

    systemd = {
      enable = true;
    };

    settings = {
      close_on_focus_loss = false;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      telemetry = false;
    };

    # extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
    #   bluetooth
    #   nix
    #   power-profile
    # ];
  };
}
