{ config, lib, pkgs, ... }: 
{
  options.nebs-bookstack.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable or disable nebs bookstack";
  };

  config = lib.mkIf config.nebs-bookstack.enable {
    services.bookstack = {
      hostname = "wiki.yeet";
      enable = true;
      appURL = "https://wiki.yeet";
      appKeyFile = config.age.secrets.nebs-bookstack-key.path;

      database = {
        user = "bookstack";
        host = "localhost";
        name = "bookstack";
        createLocally = true;
      };
      
    };
  };
}
