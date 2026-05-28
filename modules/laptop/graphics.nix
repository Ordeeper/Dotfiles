{ pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt
      intel-compute-runtime
      vulkan-loader
      libvdpau-va-gl
      mesa
    ];
  };

  boot.kernelParams = ["i915.enable_guc=3"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
