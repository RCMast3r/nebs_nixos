let
  neb = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuOj9l1wgMmCx2kZeBpjcSaYif8pCJ6PeYlW31YcdTW neb@nixos";
  ben = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOtpIpzZ1PkFItVd2WWapfgIWAQ7ymuqAlYNpGgE+w5 rcmast3r1@gmail.com";
  users = [ neb ben ];
in 
{
  # nix run github:ryantm/agenix -- -e .age -i /home/neb/.ssh/id_ed25519
  "nebs_ssh_key.age".publicKeys = users;
  "nebs-bs-env-file3.age".publicKeys = users;
  "duckdns-token.age".publicKeys = users;
  "duckdns-domains.age".publicKeys = users;
  "remotebuild-ssh-key.age".publicKeys = users;
  "qbit-vpn-env.age".publicKeys = users;
}
