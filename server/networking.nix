{config, pkgs, ...}:
{
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.hostName = "nixos"; # Define your hostname.
}

