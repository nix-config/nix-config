{
  opts,
  ...
}:
let
  relayHosts = opts.service.rustdesk-server.relayHosts;
in
{
  config = {
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
