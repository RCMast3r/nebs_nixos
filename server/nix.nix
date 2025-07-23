{config, pkgs, lib, ...}:
{
  options.nebs-nix-server.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable or disable my standard nix settings";
  };

  options.nebs-nix-server.nix-users

  config = lib.mkIf config.nebs-nix-server.enable {
    users.users.remotebuild = {
      # https://nix.dev/tutorials/nixos/distributed-builds-setup.html
      isNormalUser = true;
      createHome = false;
      group = "remotebuild";

      openssh.authorizedKeys.keyFiles = [ config.age.secrets.remotebuild-ssh-key.path ];
    
    };

    nix.settings.trusted-users = [ "remotebuild" "root" ]
  };
}