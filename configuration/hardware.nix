{ pkgs, ... }:
{
  # CPU
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

  # ZRAM to make oom killer happy
  zramSwap.enable = true;
  zramSwap.memoryMax = 2147483648; # 2GB

  # Firmware
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true; # firmware updates when supported

  # FStrim for the nvme
  services.fstrim.enable = true;

  # Touch/pen
  services.iptsd.enable = true;

  # Thermal tuning
  services.thermald = {
    enable = true;
    configFile = ./assets/thermal-conf.xml;
  };

  # Integrated graphics
  boot.initrd.kernelModules = [ "i915" ];

  hardware = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.intel-vaapi-driver
      pkgs.intel-ocl
      pkgs.intel-media-driver
      pkgs.intel-compute-runtime
      (pkgs.vpl-gpu-rt or pkgs.onevpl-intel-gpu)
    ];
    extraPackages32 = [
      pkgs.driversi686Linux.intel-vaapi-driver
      pkgs.driversi686Linux.intel-media-driver
    ];
  };
}
