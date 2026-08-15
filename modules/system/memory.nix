let
  oomPreference = section: value: {
    overrideStrategy = "asDropin";
    text = ''
      [${section}]
      ManagedOOMPreference=${value}
    '';
  };
in
{
  # gamemoded goes through the high-level option because NixOS already defines
  # its unit; setting overrideStrategy here would conflict.
  systemd.user.services.gamemoded.serviceConfig.ManagedOOMPreference = "omit";

  boot.kernel.sysctl = {
    # Not a typo: high on purpose because zram sits in front of the disk.
    "vm.swappiness" = 180;
    "vm.watermark_scale_factor" = 125;
    "vm.watermark_boost_factor" = 0;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    "vm.vfs_cache_pressure" = 50;
    "kernel.sysrq" = 244;
  };

  services.earlyoom = {
    enable = true;

    # The memory thresholds stay at their defaults (10% / 5%); only the swap
    # side is changed. 100 means "ignore swap", not "disabled": both sides are
    # ANDed, so with ~24 GiB of total swap any percentage would leave earlyoom
    # inert until long after thrashing began. Lowering these breaks it.
    freeSwapThreshold = 100;
    freeSwapKillThreshold = 100;

    enableNotifications = true;

    extraArgs = [
      "--ignore"
      "^(\\.Hyprland-wrapp|start-hyprland|Xwayland|greetd|systemd|dbus-broker(-lau)?|pipewire(-pulse)?|wireplumber)$"

      "--avoid"
      "^(\\.quickshell-wra|\\.dms-wrapped|\\.xdg-desktop-po|\\.xdg-document-p|\\.xdg-permission)$"

      "--prefer"
      "^(\\.firefox-wrappe|Isolated Web Co|Isolated Servic|Web Content|WebExtensions|Privileged Cont|RDD Process|Socket Process|Utility Process|electron|spotify|java)$"
    ];
  };

  # oomd is already enabled by default, but inert: enableUserSlices and
  # friends stay off (also the default) because the first would target
  # user.slice, whose leaves include the compositor's session scope. What was
  # missing is a policy, and it goes on app.slice below.
  systemd.oomd.settings.OOM.DefaultMemoryPressureDurationSec = "20s";

  # Only units that actually live in app.slice are listed: oomd picks victims
  # among descendants of the monitored cgroup, so preferences on session.slice
  # units (pipewire, dbus, most portals) would never be consulted.
  systemd.user.units = {
    # Helpers that live in app.slice: tiny, so killing one frees nothing, but
    # losing flatpak-session-helper takes every running Flatpak with it.
    "xdg-desktop-portal-gtk.service" = oomPreference "Service" "omit";
    "flatpak-session-helper.service" = oomPreference "Service" "omit";
    "flatpak-managed-install.service" = oomPreference "Service" "omit";
    "dconf.service" = oomPreference "Service" "omit";
    "speech-dispatcher.service" = oomPreference "Service" "omit";

    # avoid, not omit: everything launched from dms inherits its cgroup, so
    # killing it takes browser, editor and players at once. Omitting it would
    # leave oomd with almost nothing to act on in app.slice.
    "dms.service" = oomPreference "Service" "avoid";

    # On app.slice rather than user@.service: tmux panes run in transient
    # tmux-spawn-*.scope units that are siblings of app.slice, so scoping the
    # policy here keeps them out of oomd's reach entirely.
    "app.slice" = {
      overrideStrategy = "asDropin";
      text = ''
        [Slice]
        ManagedOOMMemoryPressure=kill
        ManagedOOMMemoryPressureLimit=50%
      '';
    };
  };
}
