{
  services.udev.extraRules = ''
    SUBSYSTEM=="i2c-dev", KERNEL=="i2c-[0-9]*", GROUP="video", MODE="0660"
  '';
}
