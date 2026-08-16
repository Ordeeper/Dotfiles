{ lib, username ? "nix-user", ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
        automatic = true;
        dates = "Sun 04:00";
        randomizedDelaySec = "45min";
        options = "--delete-older-than 7d";
    };

    # No daemonIOSched*: those are ionice, and neither host's I/O scheduler
    # (none on NVMe, mq-deadline on SATA) honours it.
    daemonCPUSchedPolicy = "batch";

    settings = {
      auto-optimise-store = true;
      allowed-users = [ "${username}" ];
      trusted-users = [ "root" "${username}" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      max-jobs = lib.mkDefault 2;

      extra-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];

      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      keep-build-log = false;
      keep-outputs = false;
      keep-derivations = false;
    };
  };

  # Not "idle": nix-collect-garbage holds the global GC lock, and starving it
  # would block any concurrent build.
  systemd.services.nix-gc.serviceConfig.CPUSchedulingPolicy = "batch";
}
