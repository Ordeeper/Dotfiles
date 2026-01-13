{
  description = "Ordeeper's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = inputs@{ nixpkgs, home-manager, vicinae, stylix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };
    };
    devEnv = import ./dev-env/dev.nix { inherit pkgs; };
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
                stylix.homeModules.stylix
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
                stylix.homeModules.stylix
              ];
            };
            home-manager.extraSpecialArgs = { username = "nix-user"; inputs = inputs; };
       	  }
        ];
      };
    };
    devShells = {
      x86_64-linux = devEnv.devShells;
    };
  };
}
