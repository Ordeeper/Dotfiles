{
  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
    firewall = {
        enable = true;
        allowPing = false;
        allowedTCPPorts = [ 8000 ];
    };
    nftables.enable = true;
  };
}
