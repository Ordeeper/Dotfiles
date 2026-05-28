{ pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-vaapi-driver
      vulkan-loader
      libvdpau-va-gl
      mesa
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  };
}
