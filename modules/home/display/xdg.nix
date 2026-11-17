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
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
