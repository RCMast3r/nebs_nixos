{ config, pkgs, lib, ... }:

{
  services.nginx.enable = true;

  services.nginx.virtualHosts = {
    "books.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:8123";
      };
    };
  };
}