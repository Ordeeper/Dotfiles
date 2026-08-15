{ lib, ... }:

{
  options.myLan = {
    deskflowPort = lib.mkOption {
      type = lib.types.port;
      default = 24800;
      description = "TCP port deskflow/waynergy use for keyboard/mouse sharing.";
    };

    wifiInterface = lib.mkOption {
      type = lib.types.str;
      description = "This host's WiFi network interface name.";
    };

    wiredInterface = lib.mkOption {
      type = lib.types.str;
      default = "enp2s0";
      description = "This host's wired network interface name.";
    };
  };
}
