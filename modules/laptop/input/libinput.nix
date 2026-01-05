{
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      scrollMethod = "twofinger";
      middleEmulation = true;
      accelSpeed = 0.7;
      disableWhileTyping = true;
    };
  };
}

