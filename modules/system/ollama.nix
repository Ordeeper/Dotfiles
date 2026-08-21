{ lib, ... }:

{
  services.ollama = {
    enable = true;

    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "5m";
    };

    host = "127.0.0.1";
    port = 11434;
  };

  systemd.services.ollama.wantedBy = lib.mkForce [ ];
}
