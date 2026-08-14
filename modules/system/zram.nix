{
  # algorithm and memoryPercent are set per host in modules/*/performance.nix;
  # the module's own defaults (zstd, 50%) cover a host without one.
  zramSwap = {
    enable = true;
    priority = 100;
  };
}
