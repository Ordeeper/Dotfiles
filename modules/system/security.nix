{
  security = {
    sudo.enable = false;
    doas = {
        enable = true;
        extraRules = [{
            users = [ "nix-user" ];
            keepEnv = true;
            persist = true;
        }];
    };
    protectKernelImage = true;
  };
}