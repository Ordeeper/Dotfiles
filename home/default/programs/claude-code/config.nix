{ pkgs, ... }:

{
  programs.claude-code = {
    enable = true;

    package = pkgs.claude-code.overrideAttrs (_: rec {
      version = "2.1.224";
      src = pkgs.fetchurl {
        url = "https://downloads.claude.ai/claude-code-releases/${version}/linux-x64/claude";
        sha256 = "a2b5add7dc4bcd8eaa029f4e8bdac4df7769b4073698db7989d206baf9419c2d";
      };
    });

    settings = {
      model = "claude-opus-5";
      effortLevel = "high";
    };

    mcpServers = {
      chrome-devtools = {
        type = "stdio";

        command = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "chrome-devtools-mcp@1.6.0"
          "-e"
          "${pkgs.chromium}/bin/chromium"
          "--headless"
          "--isolated"
          "--viewport"
          "1280x800"
          "--usageStatistics"
          "false"
          "--performanceCrux"
          "false"
        ];
      };
    };
  };
}
