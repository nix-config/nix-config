{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.yazi.enable;
in
{
  config = lib.mkIf enableModule {
    programs.yazi = {
      enable = true;
    };
  };
}
