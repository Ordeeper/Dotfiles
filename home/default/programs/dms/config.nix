{
  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = false;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = false;

    settings = {
      currentThemeName = "custom";
      currentThemeCategory = "generic";

      systemTrayIconTintMode = "primary";

      use24HourClock = true;
      showSeconds = false;

      showWorkspaceIndex = true;
      showWorkspaceApps = true;
      groupWorkspaceApps = false;
      maxWorkspaceIcons = 3;

      weatherEnabled = true;
      useAutoLocation = true;

      soundsEnabled = true;

      lockAtStartup = true;

      fadeToLockEnabled = true;
      fadeToDpmsEnabled = true;

      notificationHistoryEnabled = true;

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";

          enabled = true;
          position = 0;

          leftWidgets = [
            "workspaceSwitcher"
          ];

          centerWidgets = [
            {
              id = "music";
              enabled = true;
              mediaSize = 1;
            }

            {
              id = "clock";
              enabled = true;
              clockCompactMode = false;
            }

            {
              id = "weather";
              enabled = true;
            }
          ];

          rightWidgets = [
            {
              id = "systemTray";
              enabled = true;
            }

            {
              id = "cpuUsage";
              enabled = true;
            }

            {
              id = "memUsage";
              enabled = true;
              minimumWidth = true;
            }

            {
              id = "battery";
              enabled = true;
            }

            {
              id = "notificationButton";
              enabled = true;
            }

            {
              id = "controlCenterButton";
              enabled = true;
            }
          ];

          fontScale = 1.2;
          iconScale = 1.2;
        }
      ];
    };
  };
}
