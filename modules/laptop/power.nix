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
      TLP_DEFAULT_MODE = "PRF";
      PLATFORM_PROFILE_ON_AC = "cool";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      PLATFORM_PROFILE_ON_SAV = "quiet";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1;
      CPU_BOOST_ON_SAV = 0;
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

}
