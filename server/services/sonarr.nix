{config, pkgs, lib, ...}:
{
  services.sonarr = {
    enable = true;
    dataDir = "/mnt/data/sonarr_storage";
    group = "media";
    user = "media";
  };
}