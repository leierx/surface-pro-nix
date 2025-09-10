{ pkgs, lib, ... }:
{
  imports = [
    ./desktop.nix
    ./disko.nix
    ./hardware.nix
    ./localization.nix
    ./network.nix
    ./nixos.nix
    ./user.nix
  ];

  config = {
    # bootloader
    boot.loader.systemd-boot.enable = true;
    boot.tmp.cleanOnBoot = true;

    # polkit
    security.polkit.enable = true;

    # console
    console = { earlySetup = true; font = "${pkgs.terminus_font}/share/consolefonts/ter-i20b.psf.gz"; };

    # Diable root account
    users.users.root.hashedPassword = "!";

    # syslog
    services.journald.extraConfig = "MaxRetentionSec=90day";
  };
}
