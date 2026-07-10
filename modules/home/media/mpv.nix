{
  lib,
  opts,
  ...
}:
let
  cfg = opts.media.mpv or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    programs.mpv = {
      enable = true;
      config = {
        # 循环播放
        loop-playlist = "inf";
      };
    };
  };
}
