{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      model = "minimax/m2.5-free-opencode-zen";

      permission = {
        websearch = "allow";
        webfetch = "allow";
      };
    };
  };

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

}
