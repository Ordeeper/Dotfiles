{ pkgs, ... }:

{
  programs.opencode = {
    enable = true;

    package = pkgs.runCommand "opencode-dummy" {} "mkdir $out";

    settings = {
      permission = {
        websearch = "allow";
        webfetch = "allow";
        lsp = "allow";
      };

      plugin = [
        "github:kdcokenny/opencode-notify"
      ];
    };
  };

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
    OPENCODE_EXPERIMENTAL_LSP_TOOL = "true";
  };

}
