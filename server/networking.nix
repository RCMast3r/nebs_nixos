{config, pkgs, ...}:
{
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 53 6875 80 443 51820 ];
    networking.firewall.allowedUDPPorts = [ 53 51820 ];
    networking.interfaces.enp10s0.ipv4 = {
      addresses = [
        {
          address = "192.168.86.148"; # Your static IP address
          prefixLength = 24; # Netmask, 24 for 255.255.255.0
        }
      ];
    };
    networking.hostName = "nixos"; # Define your hostname.
}

