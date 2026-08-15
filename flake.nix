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
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    hyprland = {
      url = "github:hyprwm/Hyprland?submodules=1&ref=v0.56.0";
    };
    hy3 = {
      url = "github:outfoxxed/hy3?ref=hl0.56.0";
      inputs.hyprland.follows = "hyprland";
    };
    kimi-code = {
      url = "github:MoonshotAI/kimi-code";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, dms, stylix, nix-flatpak, hyprland, hy3, ... }:
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
          inherit username inputs hyprland hy3;
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
                stylix.homeModules.stylix
                dms.homeModules.dank-material-shell
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit username inputs hyprland hy3;
            };
        	  }
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit username inputs hyprland hy3;
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
                stylix.homeModules.stylix
               dms.homeModules.dank-material-shell
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit username inputs hyprland hy3;
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
