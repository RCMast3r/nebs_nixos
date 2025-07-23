{config, pkgs, lib, ... }:
{
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;
    settings = {
      no-dhcp-interface = "enp10s0";
      server = [ 
        "8.8.8.8"
        "1.1.1.1"
      ];
      no-hosts = true;
      no-poll = true;
      strict-order = true;
      domain-needed = true;
      bogus-priv = true;
      proxy-dnssec = true;
      address = [ "/yeet/192.168.86.148" ];
    };
  };
}
