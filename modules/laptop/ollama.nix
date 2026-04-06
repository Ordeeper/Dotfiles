{ pkgs, ... }:

{
  services.ollama = {
    enable = true;

    package = pkgs.ollama;

    environmentVariables = {
      OLLAMA_INTEL_GPU = "1";
      OLLAMA_KEEP_ALIVE = "24h";
      OLLAMA_NUM_THREAD = "8";
    };

    loadModels = [
      "qwen2.5:3b"
      "phi4:mini"
    ];

    host = "127.0.0.1";
    port = 11434;
  };

  environment.systemPackages = with pkgs; [
    ollama
    aider-chat
  ];
}
