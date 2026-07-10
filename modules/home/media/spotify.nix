{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.media.spotify or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
