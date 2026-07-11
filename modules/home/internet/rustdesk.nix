{
  lib,
  pkgs,
  opts,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.internet.rustdesk.enable && (!desktopTypeIsNone);
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgs; [
      # 新版客户端
      rustdesk-flutter
      # 如果您需要旧版客户端(不推荐)
      # rustdesk
    ];
  };
}
