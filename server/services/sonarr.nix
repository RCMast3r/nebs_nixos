{config, pkgs, lib, ...}:
{
  services.sonarr = {
    enable = true;
    dataDir = "/mnt/data/sonarr_data";
    group = "users";
  };
}