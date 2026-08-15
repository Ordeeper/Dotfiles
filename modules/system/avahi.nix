{ config, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = false;

    publish = {
      enable = true;
      addresses = true;
    };
  };

  networking.firewall.interfaces = {
    ${config.myLan.wiredInterface}.allowedUDPPorts = [ 5353 ];
    ${config.myLan.wifiInterface}.allowedUDPPorts = [ 5353 ];
  };
}
