{
  opts,
  ...
}:
let
  cfg = opts.hardware.networking;
  hostName = cfg.hostName;
  proxy = cfg.proxy;
  firewall = cfg.firewall;
  networkmanager = cfg.networkmanager;
  isWsl = (opts.hardware.boot-loader.type == "wsl");
in
{
  config = {
    networking = {
      inherit hostName;
      inherit proxy;
      inherit firewall;
      inherit networkmanager;
      resolvconf.enable = !isWsl;
    };
  };
}
