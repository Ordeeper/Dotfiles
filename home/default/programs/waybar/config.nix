{ pkgs, ... }:

{
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      
      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          height = 40;
          spacing = 2;
          exclusive = true;
          gtk-layer-shell = true;
          passthrough = false;
          fixed-center = true;

          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [
            "mpris"
          ];

          modules-right = [
            "cpu"
            "memory"
            "pulseaudio"
            "clock"
            "clock#simpleclock"
            "tray"
            "custom/power"
          ];

          mpris = {
            dynamic-order = [ "artist" ];
            format = "{player_icon} {dynamic}";
            format-paused = "{status_icon} <i>{dynamic}</i>";

            status-icons = {
              paused = "";
            };

            player-icons = {
              default = "";
            };
          };

          "hyprland/workspaces" = {
            on-click = "activate";
            format = "{id}";
            all-outputs = true;
            disable-scroll = false;
            active-only = false;
          };

          tray = {
            show-passive-items = true;
            spacing = 10;
          };

          "clock#simpleclock" = {
            tooltip = false;
            format = " {:%H:%M}";
          };

          clock = {
            format = " {:L%a %d %b}";

            calendar = {
              format = {
                days = "<span weight='normal'>{}</span>";
                months = "<span color='#cdd6f4'><b>{}</b></span>";
                today = "<span color='#f38ba8' weight='700'><u>{}</u></span>";
                weekdays = "<span color='#f9e2af'><b>{}</b></span>";
                weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
              };

              mode = "month";
              mode-mon-col = 1;
              on-scroll = 1;
            };

            tooltip-format =
              "<span color='#cdd6f4' font='Maple Mono NF 16'><tt><small>{calendar}</small></tt></span>";
          };

          cpu = {
            format = " {usage}%";
            tooltip = true;
            interval = 1;
          };

          memory = {
            format = " {used:0.1f}Gi";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "  muted";

            format-icons = {
              headphone = "";
              default = [ " " " " " " ];
            };

            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          };

          "custom/power" = {
            tooltip = false;
            on-click = "wlogout -p layer-shell &";
            format = "⏻";
          };
        };
      };
    };

    imports = [
      ./style.nix
    ];

    home.packages = with pkgs; [
        waybar
        playerctl
        pavucontrol
        wlogout
        waylock
    ];
}
