{ config, ... }:

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
          ${config.myLan.wiredInterface} = {
            allowedTCPPorts = [ 8000 9000 ];
          };
          ${config.myLan.wifiInterface} = {
            allowedTCPPorts = [ config.myLan.deskflowPort ];
          };
        };
    };
    nftables.enable = true;
  };

}
