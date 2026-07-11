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
    programs.obs-studio = {
      enable = true;
    };
  };
}
