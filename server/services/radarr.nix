{config, pkgs, lib, ...}:
{
  services.radarr = {
    enable = true;
    dataDir = "/mnt/data/radarr_storage";
    group = "users";
  };
}