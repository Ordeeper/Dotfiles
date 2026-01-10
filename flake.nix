{
  description = "Ordeeper's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    vicinae-extensions.url = "github:vicinaehq/extensions";
    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = inputs@{ nixpkgs, home-manager, vicinae, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
       	  {
       	    home-manager.useGlobalPkgs = false;
       	    home-manager.useUserPackages = true;
            home-manager.users.nix-user = {
              imports = [
                ./home/default/home.nix
                vicinae.homeManagerModules.default
              ];
            };
            home-manager.extraSpecialArgs = { username = "nix-user"; inputs = inputs; };
       	  }
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
       	  {
       	    home-manager.useGlobalPkgs = false;
       	    home-manager.useUserPackages = true;
            home-manager.users.nix-user = {
              imports = [
                ./home/default/home.nix
                vicinae.homeManagerModules.default
              ];
            };
            home-manager.extraSpecialArgs = { username = "nix-user"; inputs = inputs; };
       	  }
        ];
      };
    };
  };
}
