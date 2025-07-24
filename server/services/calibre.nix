{ config, pkgs, lib, ... }:
{
  services.calibre-server = {
    enable = true;
    libraries = [
      "/mnt/data/calibre_library"
    ];
    extraFlags = [
      "--enable-local-write"
    ];
    group = "users";
    user = "neb";
  };
  services.calibre-web = {
    enable = true;
    dataDir = "/mnt/data/calibre_web_data";
    options.enableBookUploading = true;
    options.enableBookConversion = true;
    group = "users";
    user = "neb";
  };
}