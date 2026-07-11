{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.internet.qq.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      qq
    ];
  };
}
