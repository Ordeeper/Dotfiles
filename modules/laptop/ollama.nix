{ lib, pkgs, ... }:

{
  services.ollama = {
    enable = true;

    package = pkgs.ollama;

    environmentVariables = {
      OLLAMA_INTEL_GPU = "1";
      OLLAMA_KEEP_ALIVE = "5m";
      OLLAMA_NUM_THREAD = "8";
    };

    host = "127.0.0.1";
    port = 11434;
  };

  systemd.services.ollama.wantedBy = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    ollama
  ];
}
