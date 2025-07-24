# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  age.secrets.nebs-bs-env-file3.file = ./secrets/nebs-bs-env-file3.age;
  age.secrets.duckdns-token.file = ./secrets/duckdns-token.age;
  age.secrets.duckdns-domains.file = ./secrets/duckdns-domains.age;
  age.secrets.nebs_ssh_key.file = ./secrets/nebs_ssh_key.age;
  age.secrets.remotebuild-ssh-key.file = ./secrets/remotebuild-ssh-key.age;
  age.secrets.qbit-vpn-env.file = ./secrets/qbit-vpn-env.age;
  age.secrets.unpackerr-env.file = ./secrets/unpackerr-env.age;
  
  age.identityPaths = [ "/home/neb/.ssh/id_ed25519" ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.neb = {
    isNormalUser = true;
    description = "neb";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    # openssh.authorizedKeys.keyFiles = [ config.age.secrets.nebs_ssh_key.path ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    git
    htop
    intel-gpu-tools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowedUsers = null;
      UseDns = true;
    };
  };

  # Open ports in the firewall.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  fileSystems."/mnt/data" = {
    device = "UUID=72395080-ec8e-43ce-a59a-381bec4b1a86";
    fsType = "btrfs";
    options = [ "compress=zstd" ]; # Optional Btrfs options
  };

  systemd.services."fix-permissions-mnt-data" = {
    wantedBy = [ "local-fs.target" ];
    after = [ "mnt-data.mount" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "/run/current-system/sw/bin/chown neb:users /mnt/data"
        "/run/current-system/sw/bin/chmod 755 /mnt/data"
      ];
    };
  };
  
  programs.git = {
    enable = true;
    config = {
      user.email = "rcmast3r1@gmail.com";
      user.name = "Ben Hall";
    };
  };

  virtualisation.docker = {
    enable = true;
  };
  
}
