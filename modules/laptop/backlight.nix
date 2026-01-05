{ pkgs, ... }:

{
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", \
    RUN+="${pkgs.coreutils}/bin/chgrp video $sys$devpath/brightness", \
    RUN+="${pkgs.coreutils}/bin/chmod g+w $sys$devpath/brightness"
  '';
}

