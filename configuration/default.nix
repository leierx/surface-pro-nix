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
    # bootloader + theme
    boot = {
      loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";

        # GRUB theme
        theme = pkgs.stdenv.mkDerivation {
          name = "grub_theme";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "c96f868e75707ea2b2eb2869a3d67bd9c151cee6";
            hash = "sha256-QHqsQUEYxa04je9r4FbOJn2FqRlTdBLyvwZXw9JxWlQ=";
          };
          installPhase = ''
            mkdir -p $out
            tar -xf themes/nixos.tar -C $out
          '';
        };
      };

      loader.timeout = 5;
      loader.efi.canTouchEfiVariables = true;
      tmp.cleanOnBoot = true;
    };

    # polkit
    security.polkit.enable = true;

    # console
    console = { earlySetup = true; font = "${pkgs.terminus_font}/share/consolefonts/ter-i32b.psf.gz"; };

    # Diable root account
    users.users.root.hashedPassword = "!";

    # syslog
    services.journald.extraConfig = "MaxRetentionSec=90day";
  };
}
