{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.internet.telegram-desktop.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
