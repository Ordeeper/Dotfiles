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
            allowedTCPPorts = [ 8000 9000 ];
          };
          # deskflow serves from the laptop, which reaches the LAN over wifi.
          wlan0 = {
            allowedTCPPorts = [ 24800 ];
          };
        };
    };
    nftables.enable = true;
  };

}
