{
  boot.kernel.sysctl."vm.page-cluster" = 1;

  zramSwap = {
    algorithm = "zstd";
    memoryPercent = 50;
  };

  nix.settings = {
    max-jobs = 2;
    cores = 6;
  };
}
