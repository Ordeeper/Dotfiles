{ pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
}
