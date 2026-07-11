{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.tool.mission-center.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      mission-center
    ];
  };
}
