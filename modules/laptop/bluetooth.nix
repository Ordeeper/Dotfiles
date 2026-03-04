{pkgs, ...}:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = false;
      };
    };
  };

  services.blueman.enable = true;

}
