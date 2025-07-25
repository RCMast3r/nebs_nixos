{ config, pkgs, lib, ... }:
{
  services.calibre-server = {
    enable = true;
    # because this boi is not smart at all you have to creat the library before using this module: `calibredb --with-library /mnt/data/calibre_server list` fuck me i guess
    libraries = [
      "/mnt/data/calibre_library"
    ];
    extraFlags = [
      "--enable-local-write"
    ];
    group = "media";
    user = "media";
  };
  services.calibre-web = {
    enable = true;
    dataDir = "/mnt/data/calibre_web_data";
    options.enableBookUploading = true;
    options.enableBookConversion = true;
    group = "media";
    user = "media";
  };
}
