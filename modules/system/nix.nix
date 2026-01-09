{
  nix = {
    gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

    settings = {
      auto-optimise-store = true;
      allowed-users = [ "nix-user" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
