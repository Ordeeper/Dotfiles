{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(nav, esc)";
          insert = "S-insert";
        };
        nav = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
        };
      };
    };
  };
}
