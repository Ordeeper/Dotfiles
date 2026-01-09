{
  networking = {
      networkmanager.enable = true;
      firewall = {
          enable = true;
          allowPing = false;
      };
      nftables.enable = true;
  };
}
