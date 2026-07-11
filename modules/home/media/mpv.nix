{
  lib,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.media.mpv.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    programs.mpv = {
      enable = true;
      config = {
        # 循环播放
        loop-playlist = "inf";
      };
    };
  };
}
