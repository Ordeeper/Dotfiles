{ config, pkgs, ... }:

let
  catppuccinThemeFile = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/AvengeMedia/dms-plugin-registry/0abd7c822dd6e42367e9c15f44112ed779d72bf6/themes/catppuccin/theme.json";
    hash = "sha256-reELIdD8N+19CXo4RK8TSq0Yp/iXjblZO83M2GRVoRs=";
  };

in
{
  xdg.configFile."DankMaterialShell/themes/catppuccin/theme.json".source = catppuccinThemeFile;

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

    session = {
      wallpaperPath = "${config.home.homeDirectory}/Pictures/who-am-i.png";
      wallpaperTransition = "pixelate";
      doNotDisturb = true;
      nightModeEnabled = true;
    };

    settings = {
      configVersion = 13;

      currentThemeName = "custom";
      currentThemeCategory = "registry";
      customThemeFile = "${config.xdg.configHome}/DankMaterialShell/themes/catppuccin/theme.json";
      registryThemeVariants.catppuccin.dark = {
        flavor = "mocha";
        accent = "lavender";
      };

      launcherStyle = "spotlight";
      rememberLastMode = false;
      launcherUseOverlayLayer = true;
      dankLauncherV2IncludeFilesInAll = true;
      notepadSlideoutSide = "right";
      notepadShowLineNumbers = true;

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
              id = "cpuTemp";
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
              showBatteryTime = true;
              showBatteryTimeOnlyOnBattery = true;
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

            {
              id = "powerMenuButton";
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
