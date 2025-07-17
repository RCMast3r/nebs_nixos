{config, pkgs, ...}:
{
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 6875 ];
    networking.hostName = "nixos"; # Define your hostname.
}

