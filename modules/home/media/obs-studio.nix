{
  lib,
  opts,
  ...
}:
let
  cfg = opts.media.obs-studio or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
in
{
  config = lib.mkIf finallyEnable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
