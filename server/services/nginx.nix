{ config, pkgs, lib, ... }:

{
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "rcmast3r1@gmail.com";
  };

  services.nginx.enable = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.recommendedOptimisation = true;
  services.nginx.recommendedProxySettings = true;
  
  services.nginx.virtualHosts = {

    # "portainer.yeet" = {
    #   locations."/" = {
    #     proxyPass = "https://192.168.86.28:9443";
    #   };
    # };
    "ll.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:5299";
      };
    };
    "wg.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:51821";
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
    
    "movies.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.radarr.settings.server.port}";
      };
    };
    
    "qbit.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:8081";
      };
    };

    "tv.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:8989";
      };
    };
    
    "books.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.calibre-web.listen.port}";
      };
    };

    "calibre.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.calibre-server.port}";
      };
    };

    "tw.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:6030";
      };
    };

    "files.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:3923";
      };
    };

    "jammy.yeet" = {
      locations."/" = {
        proxyPass = "http://localhost:8097";
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
