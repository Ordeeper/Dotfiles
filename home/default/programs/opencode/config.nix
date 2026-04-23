{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      plugin = [
        "opencode-omniroute-auth"
      ];

      permission = {
        websearch = "allow";
        webfetch = "allow";
        lsp = "allow";
      };
    };
  };

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
    OPENCODE_EXPERIMENTAL_LSP_TOOL = "true";
  };

}
