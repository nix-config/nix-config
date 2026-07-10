{
  lib,
  opts,
  ...
}:
let
  cfg = opts.i18n or { };
  finallyEnable = (cfg.locale or "en-us") == "zh-cn";
in
{
  config = lib.mkIf finallyEnable {
    # 时区配置
    time.timeZone = "Asia/Shanghai";
    # 语言配置
    i18n = {
      # 系统中文环境配置
      defaultLocale = "zh_CN.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "zh_CN.UTF-8";
        LC_IDENTIFICATION = "zh_CN.UTF-8";
        LC_MEASUREMENT = "zh_CN.UTF-8";
        LC_MONETARY = "zh_CN.UTF-8";
        LC_NAME = "zh_CN.UTF-8";
        LC_NUMERIC = "zh_CN.UTF-8";
        LC_PAPER = "zh_CN.UTF-8";
        LC_TELEPHONE = "zh_CN.UTF-8";
        LC_TIME = "zh_CN.UTF-8";
      };
      supportedLocales = [
        "zh_CN.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
    };
  };
}
