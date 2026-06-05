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
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  };

  outputs = inputs@{ nixpkgs, home-manager, vicinae, dms, stylix, nix-flatpak, ... }:
  let
    system = "x86_64-linux";
    username = "nix-user";
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
        specialArgs = {
          inherit username inputs;
        };
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
       	  {
       	    home-manager.useGlobalPkgs = false;
       	    home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              imports = [
                ./home/default/home.nix
                nix-flatpak.homeManagerModules.nix-flatpak
                vicinae.homeManagerModules.default
                stylix.homeModules.stylix
                dms.homeModules.dank-material-shell
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit username inputs;
            };
       	  }
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit username inputs;
        };
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
       	  {
       	    home-manager.useGlobalPkgs = false;
       	    home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              imports = [
                ./home/default/home.nix
                nix-flatpak.homeManagerModules.nix-flatpak
                vicinae.homeManagerModules.default
                stylix.homeModules.stylix
               dms.homeModules.dank-material-shell
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit username inputs;
            };
       	  }
        ];
      };
    };
    devShells = {
      x86_64-linux = devEnv.devShells;
    };
  };
}
