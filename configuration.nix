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
  age.secrets.rb-ssh-key.file = ./secrets/rb-ssh-key.age;
  age.secrets.qbit-vpn-env.file = ./secrets/qbit-vpn-env.age;
  age.secrets.unpackerr-env.file = ./secrets/unpackerr-env.age;
  age.secrets.wg-easy-env.file = ./secrets/wg-easy-env.age;
  
  age.secrets.copyparty-admin.file = ./secrets/copyparty-admin.age;
  age.secrets.copyparty-admin.group = "wheel";
  age.secrets.copyparty-admin.mode = "660";

  age.secrets.mam-curl.file = ./secrets/mam-curl.age;

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
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOtpIpzZ1PkFItVd2WWapfgIWAQ7ymuqAlYNpGgE+w5 rcmast3r1@gmail.com" 
    ];
  };
  
  users.groups.media = {
    gid = 1234;
  };

  users.users.media = {
    isNormalUser = true;
    description = "media";
    uid =  1234;
    group = "media";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    git
    htop
    intel-gpu-tools
  ];

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

  system.activationScripts.setMediaOwnership.text = ''
    echo "Fixing media folder ownership..."
    chown -R :media /mnt/data/jellyfin
    chown -R :media /mnt/data/radarr_storage
    chown -R :media /mnt/data/sonarr_data
    chown -R :media /mnt/data/sonarr_storage
    chown -R :media /mnt/data/calibre_web_data
    chown -R :media /mnt/data/calibre_library
    chown -R :media /mnt/data/qbt_config
    chown -R :media /mnt/data/mass_storage
    chown -R :media /mnt/data/fileserver

    chmod -R g+rwX /mnt/data/jellyfin
    chmod -R g+rwX /mnt/data/radarr_storage
    chmod -R g+rwX /mnt/data/sonarr_data
    chmod -R g+rwX /mnt/data/sonarr_storage
    chmod -R g+rwX /mnt/data/calibre_web_data
    chmod -R g+rwX /mnt/data/calibre_library
    chmod -R g+rwX /mnt/data/qbt_config
    chmod -R g+rwX /mnt/data/mass_storage
    chmod -R g+rwX /mnt/data/fileserver

    find /mnt/data/jellyfin -type d -exec chmod g+s {} \;
    find /mnt/data/radarr_storage -type d -exec chmod g+s {} \;
    find /mnt/data/sonarr_data -type d -exec chmod g+s {} \;
    find /mnt/data/sonarr_storage -type d -exec chmod g+s {} \;
    find /mnt/data/calibre_web_data -type d -exec chmod g+s {} \;
    find /mnt/data/calibre_library -type d -exec chmod g+s {} \;
    find /mnt/data/qbt_config -type d -exec chmod g+s {} \;
    find /mnt/data/mass_storage -type d -exec chmod g+s {} \;
    find /mnt/data/fileserver -type d -exec chmod g+s {} \;
  '';

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
