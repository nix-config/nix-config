{
  lib,
  opts,
  ...
}:
let
  cfg = opts.hardware.networking or { };
  hostName = cfg.hostName or "nixos";
  proxy = cfg.proxy or { };
  firewall = cfg.firewall or { enable = false; };
  networkmanager = cfg.networkmanager or { enable = false; };
  isWsl = opts.hardware.boot-loader.type == "wsl";
  finallyEnable = cfg.enable or true;
in
{
  config = lib.mkIf finallyEnable {
    networking = {
      inherit hostName;
      inherit proxy;
      inherit firewall;
      inherit networkmanager;
      resolvconf.enable = !isWsl;
    };
  };
}
