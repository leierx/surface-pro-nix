{
  networking = {
    networkmanager = {
      enable = true;
      settings = {
        main = { no-auto-default = "*"; }; # do not automatically create connection profiles.
      };
    };

    enableIPv6 = false; # all my homies use ipv4

    firewall = {
      enable = true;
      allowPing = false;
      logRefusedConnections = true;
    };
  };
}
