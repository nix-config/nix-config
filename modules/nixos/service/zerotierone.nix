{
  opts,
  ...
}:
let
  joinNetworks = opts.service.zerotierone.joinNetworks;
in
{
  config = {
    services.zerotierone = {
      enable = true;
      inherit joinNetworks;
    };
  };
}
