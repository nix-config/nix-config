{
  lib,
  opts,
  ...
}:
let
  cfg = opts.service.rustdesk-server;
  enableModule = cfg.enable;
  relayHosts = cfg.relayHosts;
in
{
  config = lib.mkIf enableModule {
    services.rustdesk-server = {
      enable = true;
      openFirewall = true;
      signal = {
        enable = true;
        inherit relayHosts;
      };
      relay.enable = true;
    };
  };
}
