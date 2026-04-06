{ pkgs, ... }:

{
  services.ollama = {
    enable = true;

   package = pkgs.ollama-vulkan;

    environmentVariables = {
      OLLAMA_NUM_THREAD = "4";
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
