{
  networking = {
      networkmanager.enable = true;
      firewall = {
          enable = true;
          allowPing = false;
          allowedTCPPorts = [ 8000 ];
      };
      nftables.enable = true;
  };
}
