{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
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
