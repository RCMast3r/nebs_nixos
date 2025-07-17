let
  neb = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuOj9l1wgMmCx2kZeBpjcSaYif8pCJ6PeYlW31YcdTW neb@nixos";
    
  users = [ neb ];
in 
{
  "nebs_ssh_key.age".publicKeys = users;
  "nebs-bookstack-key.age".publicKeys = users;
}
