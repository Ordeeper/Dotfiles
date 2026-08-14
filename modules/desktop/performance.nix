{
  boot.kernel.sysctl."vm.page-cluster" = 1;

  zramSwap = {
    algorithm = "lz4";
    memoryPercent = 40;
  };

  nix.settings = {
    max-jobs = 1;
    cores = 4;
  };
}
