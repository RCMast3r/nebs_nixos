{ config, pkgs, ...}:
{
  services.copyparty = {
    enable = true;
    accounts = {
    # specify the account name as the key
      admin = {
        passwordFile = config.age.secrets.copyparty-admin.path;
      };
    };

    volumes = {
      "/" = {
        path = "/mnt/data/fileserver";
        access = {
          rw="*";
          A = ["admin"];
        };
      };
    };
  };
  users.users."${config.services.copyparty.user}".extraGroups = [ "wheel" "media" ];
}