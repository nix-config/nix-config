{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.internet.rustdesk or { };
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsNone);
in
{
  config = lib.mkIf finallyEnable {
    home.packages = with pkgs; [
      # 新版客户端
      rustdesk-flutter
      # 如果您需要旧版客户端(不推荐)
      # rustdesk
    ];
  };
}
