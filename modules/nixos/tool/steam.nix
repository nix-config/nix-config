{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
in
{
  config = lib.mkIf enableModule {
    programs.steam = {
      enable = true;
    };
  };
}
