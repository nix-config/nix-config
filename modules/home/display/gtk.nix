{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsWsl = (opts.display.desktopType or "none") == "wsl";
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (!desktopTypeIsNone) && (!desktopTypeIsWsl);
in
{
  config = lib.mkIf finallyEnable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
