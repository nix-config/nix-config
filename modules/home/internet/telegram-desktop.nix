{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.internet.telegram-desktop or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
