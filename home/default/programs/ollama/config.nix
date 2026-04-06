{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    acceleration = false;

    environmentVariables = {
      OLLAMA_NUM_THREAD = "4";
      OLLAMA_SKIP_CPU_CHECK = "1";
    };

    host = "127.0.0.1";
    port = 11434;
  };

  home.packages = with pkgs; [
    ollama
  ];
}
