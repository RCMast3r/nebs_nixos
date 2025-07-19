{config, pkgs, lib, ...}:
{
  services.duckdns = {
    enable = true;
    tokenFile = config.age.secrets.duckdns-token.path;
    domainsFile = config.age.secrets.duckdns-domains.path;
  };
}