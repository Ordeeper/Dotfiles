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

      fadeToLockEnabled = true;
      fadeToDpmsEnabled = true;

      notificationHistoryEnabled = true;

      lockScreenShowMediaPlayer = false;

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
              id = "privacyIndicator";
              enabled = true;
            }

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
              id = "colorPicker";
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

      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }

        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }

        {
          id = "wifi";
          enabled = true;
          width = 50;
        }

        {
          id = "builtin_vpn";
          enabled = true;
          width = 50;
        }

        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }

        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }

        {
          id = "doNotDisturb";
          enabled = true;
          width = 50;
        }

        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }

        {
          id = "darkMode";
          enabled = true;
          width = 50;
        }

        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
      ];

      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowVpnIcon = true;
      controlCenterShowScreenSharingIcon = false;

      controlCenterShowBrightnessIcon = false;
      controlCenterShowMicIcon = false;
      controlCenterShowBatteryIcon = false;
      controlCenterShowPrinterIcon = false;

    };
  };
}
