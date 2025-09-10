{
  disko.devices = {
    disk.nvme0 = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            start = "1MiB";
            size = "512MiB";
            type = "EF00"; # EFI System
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" "noatime" ];
            };
          };
          root = {
            size = "100%";
            type = "8300"; # Linux filesystem
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };

  services.fstrim.enable = true;
}
