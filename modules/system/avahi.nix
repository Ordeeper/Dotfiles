{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    # Defaults to true, which opens 5353 on every interface. Scoped below instead.
    openFirewall = false;

    # publish.enable defaults to false, which sets disable-publishing=yes and
    # blocks all mDNS registration -- including this host's own hostname.
    # Without this, laptop.local is never announced and never resolves.
    publish = {
      enable = true;
      addresses = true;
    };
  };

  # openFirewall opens mDNS on every interface; scope it like the rest of
  # the firewall config instead (see networking.nix).
  networking.firewall.interfaces = {
    enp2s0.allowedUDPPorts = [ 5353 ];
    wlan0.allowedUDPPorts = [ 5353 ];
  };
}
