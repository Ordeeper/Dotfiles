{ pkgs }:

with pkgs;
{
  nixpkgs.config.allowUnfree = true;
  devShells = {
    flutter = import ./environments/flutter.nix { inherit pkgs; };
    python = mkShell {
      packages = [ pkgs.python310 pkgs.pipenv ];
      shellHook = ''
        echo "Python devShell activated"
      '';
    };
    node = mkShell {
      packages = [ pkgs.nodejs pkgs.yarn ];
      shellHook = ''
        echo "Node devShell activated"
      '';
    };
  };
}
