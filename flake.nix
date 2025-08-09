{
  description = "nebs nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    agenix.url = "github:ryantm/agenix";
    copyparty.url = "github:9001/copyparty";
  };

  outputs = { self, nixpkgs, agenix, copyparty, ... }@inputs: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./server/services/bookstack.nix
      	./server/services/nginx.nix
      	./server/services/prowlarr.nix
      	./server/services/duckdns.nix
        ./server/services/code-server.nix
        ./server/services/radarr.nix
        ./server/services/dns.nix
        ./server/services/qbit_vpn.nix
        ./server/services/unpackerr.nix
        ./server/services/jellyfin.nix
        ./server/services/sonarr.nix
        ./server/services/calibre.nix
        ./server/services/wg-easy.nix
        ./server/services/twitch-auto-miner.nix
        ./server/services/copyparty.nix
        ./server/services/lazylibrarian.nix
        ./server/networking.nix
        ./server/nix.nix
        
        # ./server/nix.nix
        agenix.nixosModules.default
        copyparty.nixosModules.default
        ({config, pkgs, ...} : {
          config.nixpkgs.overlays = [ copyparty.overlays.default ];
          config.nebs-nix-server.enable = true;
        })
  
      ];
    };
  };
}
