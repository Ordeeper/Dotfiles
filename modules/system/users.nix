
{ pkgs, ... }:

{
  users.users.nix-user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
