{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    # Defaults to true, which opens 5353 on every interface. Scoped below instead.
    openFirewall = false;
  };

  # openFirewall opens mDNS on every interface; scope it like the rest of
  # the firewall config instead (see networking.nix).
  networking.firewall.interfaces = {
    enp2s0.allowedUDPPorts = [ 5353 ];
    wlan0.allowedUDPPorts = [ 5353 ];
  };
}
