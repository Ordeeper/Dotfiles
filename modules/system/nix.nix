{
  nix = {
    gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      allowed-users = [ "nix-user" ];
      trusted-users = [ "root" "nix-user" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      keep-build-log = false;
      keep-outputs = false;
      keep-derivations = false;
    };
  };
}
