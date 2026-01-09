{
  security = {
    sudo.enable = false;
    doas = {
        enable = true;
        extraRules = [{
            users = [ "nix-user" ];
            keepEnv = true;
        }];
    };
    protectKernelImage = true;
  };
}