{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.service.nginx.enable;
in
{
  config = lib.mkIf enableModule {
    services.nginx = {
      enable = true;
    };
  };
}
