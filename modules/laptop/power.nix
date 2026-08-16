{
  services.logind = {
    settings = {
      Login = {
        # Not "hibernate": security.protectKernelImage injects `nohibernate`.
        HandlePowerKey = "suspend";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
        IdleAction = "suspend";
        IdleActionSec = "30min";
      };
    };
  };

  services.thermald.enable = true;
  services.upower = {
    enable = true;
    criticalPowerAction = "PowerOff";
  };

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

}
