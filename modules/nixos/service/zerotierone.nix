{
  lib,
  opts,
  ...
}:
let
  cfg = opts.service.zerotierone;
  enableModule = cfg.enable;
  joinNetworks = cfg.joinNetworks;
in
{
  config = lib.mkIf enableModule {
    services.zerotierone = {
      enable = true;
      inherit joinNetworks;
    };
  };
}
