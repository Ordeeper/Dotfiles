{ username ? "nix-user", pkgs, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
