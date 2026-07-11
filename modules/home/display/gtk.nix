{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsWsl = (opts.display.desktopType == "wsl");
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = (!desktopTypeIsNone) && (!desktopTypeIsWsl);
in
{
  config = lib.mkIf enableModule {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
