{ username ? "nix-user", pkgs, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "docker" "gamemode" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
