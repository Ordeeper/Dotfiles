{
  boot = {
     tmp.cleanOnBoot = true;
     loader = {
       systemd-boot.enable = true;
       systemd-boot.consoleMode = "max";
       systemd-boot.editor = false;
       efi.canTouchEfiVariables = true;
       timeout = 3;
    };
  };
}
