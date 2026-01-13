{pkgs, ...}:
{
  services.printing = {
    enable = true;

    drivers = [
      pkgs.cups-filters
    ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Zebra_ZTC_ZD220_203dpi_ZPL";
        deviceUri = "usb://Zebra%20Technologies/ZTC%20ZD220-203dpi%20ZPL?serial=D5J243206267";
        description = "Zebra ZTC ZD220-203dpi ZPL";
        location = "Local";
        model = "drv:///sample.drv/zebra.ppd";
        ppdOptions = {
          fitplot                     = "true";
          "orientation-requested"     = "3";
          scaling                     = "100";

          PageSize                    = "w288h432";

          zeMediaTracking             = "Web Mark";
          MediaType                   = "Saved Thermal Direct";

          Resolution                  = "203dpi";
          Darkness                    = "5";

          zePrintRate                 = "Default";
          zePrintMode                 = "Tear";

          # zeLabelTop = "200";       # ajuste do gap superior, se quiser
        };
      }
    ];
    ensureDefaultPrinter = "Zebra_ZTC_ZD220_203dpi_ZPL";
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];

  users.users.nix-user.extraGroups = [ "lp" ];
}
