{
  lib,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.media.obs-studio.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    programs.obs-studio = {
      enable = true;
    };
  };
}
