{
  lib,
  opts,
  ...
}:
let
  cfg = opts.media.obs-studio or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
