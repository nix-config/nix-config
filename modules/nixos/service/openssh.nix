{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.service.openssh.enable;
in
{
  config = lib.mkIf enableModule {
    services = {
      openssh.enable = true;
    };
  };
}
