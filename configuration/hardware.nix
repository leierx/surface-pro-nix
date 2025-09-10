{ pkgs, ... }:
{
  # CPU
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  # Battery
  services.power-profiles-daemon.enable = true;

  # ZRAM to make oom killer happy
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  # Firmware
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true; # firmware updates when supported

  # FStrim for the nvme
  services.fstrim.enable = true;

  # Touch/pen
  services.iptsd.enable = true;

  # auto-rotation
  hardware.sensor.iio.enable = true;

  # Thermal tuning
  services.thermald = {
    enable = true;
    configFile = ./assets/thermal-conf.xml;
  };

  # Integrated graphics
  boot.initrd.kernelModules = [ "i915" ];
  # if it flickers
  # boot.kernelParams = [ "i915.enable_psr=0" ];

  hardware = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # Preferred on modern Intel
      intel-vaapi-driver # (kept for compatibility)
      intel-compute-runtime # OpenCL
      (vpl-gpu-rt or onevpl-intel-gpu)
    ];
    extraPackages32 = [
      pkgs.driversi686Linux.intel-vaapi-driver
      pkgs.driversi686Linux.intel-media-driver
    ];
  };
}
