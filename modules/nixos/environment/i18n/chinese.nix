{
  lib,
  opts,
  vars,
  ...
}:
let
  enableModule = (opts.environment.i18n.type == "zh-cn");
  locale = vars.locales.zh-cn;
  fallbackLocale = vars.locales.en-us;
in
{
  config = lib.mkIf enableModule {
    # 时区配置
    time.timeZone = "Asia/Shanghai";
    # 语言配置
    i18n = {
      # 系统中文环境配置
      defaultLocale = locale.posix;
      extraLocaleSettings = {
        LC_ADDRESS = locale.posix;
        LC_IDENTIFICATION = locale.posix;
        LC_MEASUREMENT = locale.posix;
        LC_MONETARY = locale.posix;
        LC_NAME = locale.posix;
        LC_NUMERIC = locale.posix;
        LC_PAPER = locale.posix;
        LC_TELEPHONE = locale.posix;
        LC_TIME = locale.posix;
      };
      supportedLocales = [
        "${locale.posix}/UTF-8"
        "${fallbackLocale.posix}/UTF-8"
      ];
    };
  };
}
