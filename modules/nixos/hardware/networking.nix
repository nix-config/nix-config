{
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
in
{
  networking = {
    inherit hostName;
    inherit proxy;
    inherit firewall;
    inherit networkmanager;
    resolvconf.enable = !isWsl;
  };
}
