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
    pd.enable = true;
    settings = {
      TLP_AUTO_SWITCH = 0;
      TLP_DEFAULT_MODE = "BAL";
      PLATFORM_PROFILE_ON_SAV = "quiet";
    };
  };

}
