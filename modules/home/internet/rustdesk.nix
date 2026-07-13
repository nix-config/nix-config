{
  lib,
  opts,
  pkgSets,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
in
{
  config = lib.mkIf enableModule {
    home.packages = with pkgSets.pkgs-rustdesk-flutter; [
      # 新版客户端
      rustdesk-flutter
      # 如果您需要旧版客户端 (不推荐)
      # rustdesk
    ];
  };
}
