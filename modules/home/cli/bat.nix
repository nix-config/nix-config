{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.cli.bat.enable;
in
{
  config = lib.mkIf enableModule {
    programs.bat = {
      enable = true;
    };
  };
}
