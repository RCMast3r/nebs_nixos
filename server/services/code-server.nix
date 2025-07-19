{config, pkgs, lib, ...}:
{
  services.code-server = {
    enable = true;
    user = "neb";
    auth = "none";
    host = "127.0.0.1";
    proxyDomain = "server.yeet";
    disableTelemetry = true;
    disableUpdateCheck = true;
    extensionsDir = "/home/neb/.code-server-extensions";
  };
}
