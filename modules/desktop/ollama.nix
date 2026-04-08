{ pkgs, ... }:

{
  services.ollama = {
    enable = true;

   package = pkgs.ollama-cpu;

    environmentVariables = {
      OLLAMA_NUM_THREAD = "4";
      OLLAMA_KEEP_ALIVE = "24h";
    };

    loadModels = [
      "qwen2.5:3b"
    ];

    host = "127.0.0.1";
    port = 11434;
  };

  environment.systemPackages = with pkgs; [
    ollama
  ];
}
