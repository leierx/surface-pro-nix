{
  # ZRAM to make oom killer happy
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  # touchscreen
  services.iptsd = {
    enable = true;
    config = {
      Config = {
        BlockOnPalm = true;
        TouchThreshold = 20;
        StabilityThreshold = 0.1;
      };
    };
  };

  # WORKAROUND: Volume Buttons
  # boot.kernelModules = ["pinctrl_sunrisepoint"];

  # WORKAROUND: Audio and Camera
  # boot.blacklistedKernelModules = [ "ipu3_imgu" ];
}
