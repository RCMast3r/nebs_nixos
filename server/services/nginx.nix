{ config, pkgs, lib, ... }:

{
  services.nginx.enable = true;

  services.nginx.virtualHosts = {
    "books.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:8123";
      };
    };
    "movies.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:7878";
      };
    };
    
    "portainer-old.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.24:9443";
      };
    }; 
    "portainer.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:9443";
      };
    };
    
    "qbit.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:8081";
      };
    };
    "tv.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:8989";
      };
    };
    "wg.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:51821";
      };
    };
    

    "wiki.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:6875";
      };
    };
    
  };
}