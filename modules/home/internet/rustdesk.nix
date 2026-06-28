{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.internet.rustdesk or { };
  finallyEnable = (cfg.enable or false) && ((opts.desktop.type or "none") != "none");
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
