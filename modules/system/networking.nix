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
        interfaces = {
          enp2s0 = {
            allowedTCPPorts = [ 8000 9000 24800 ];
          };
        };
    };
    nftables.enable = true;
  };

}
