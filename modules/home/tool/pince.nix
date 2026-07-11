{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.tool.pince.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      pince
    ];
  };
}
