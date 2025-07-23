{ config, pkgs, lib, ... }:

{
  services.nginx.enable = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.recommendedOptimisation = true;
  services.nginx.recommendedProxySettings = true;
  security.acme = {
    acceptTerms = true;
    defaults.email = "rcmast3r1@gmail.com";
  };
  services.nginx.virtualHosts = {
    "jammy.benhall.tech" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://192.168.86.28:8097";
      };
    };
    "books.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:8123";
      };
    };
    "movies-old.yeet" = {
      locations."/" = {
        proxyPass = "http://192.168.86.28:7878";
      };
    };
    
    "portainer-old.yeet" = {
      locations."/" = {
        proxyPass = "https://192.168.86.24:9443";
      };
    }; 
    "portainer.yeet" = {
      locations."/" = {
        proxyPass = "https://192.168.86.28:9443";
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
    "prowlarr.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:9696";
      };
    };
    "movies-new.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.radarr.settings.server.port}";
      };
    };
    
    "${builtins.toString config.services.code-server.proxyDomain}" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${builtins.toString config.services.code-server.port}";
        proxyWebsockets = true;
      };
    };
  };
}
