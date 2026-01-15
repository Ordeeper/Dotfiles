{pkgs, ...}:

{
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.mise;

    globalConfig = {
      plugins = {
        nix = "https://github.com/jbadeau/mise-nix.git";
      };

      tools = {
        "nix:nodejs" = "24.11.1";
        "nix:bun" = "1.3.5";
        "nix:python" = "3.11";
        "nix:php" = "8.4.16";
        "nix:go" = "1.25.5";
      };

      settings.experimental = true;
    };
  };
}
