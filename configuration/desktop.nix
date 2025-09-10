{ pkgs, ... }:
{
  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };
  security.rtkit.enable = true;

  # desktop
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # fonts
  fonts.enableDefaultPackages = true;
  fonts.packages = [
    dejavu_fonts noto-fonts noto-fonts-cjk-sans noto-fonts-emoji noto-fonts-color-emoji liberation_ttf fira-code fira-code-symbols hack-font jetbrains-mono adwaita-fonts
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # disable gnome bloat
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  home-manager.sharedModules = [
    # cursor
    ({
      home.pointerCursor = {
        name = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
        x11 = {
          enable = true;
          defaultCursor = "left_ptr";
        };
        gtk.enable = true;
      };
    })

    # gtk
    ({
      gtk = {
        enable = true;
        font = { name = "gnome"; package = pkgs.cantarell-fonts; size = null; };
        theme = { name = "adw-gtk3-dark"; package = pkgs.adw-gtk3; };
        iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };

        gtk3 = {
          bookmarks = [ ]; # for GTK file browsers mainly
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-enable-animations = 0;
            gtk-enable-primary-paste = 0;
            gtk-recent-files-enabled = 0;
          };
          extraCss = "";
        };

        gtk4 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
            gtk-enable-animations = 0;
            gtk-enable-primary-paste = 0;
            gtk-recent-files-enabled = 0;
          };
          extraCss = "";
        };
      };
    })
  ];
}
