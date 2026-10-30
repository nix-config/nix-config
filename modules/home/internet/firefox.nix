{
  lib,
  pkgs,
  opts,
  vars,
  inputs,
  pkgSets,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
  i18nType = opts.environment.i18n.type;
  locale = vars.locales.${i18nType};
  fallbackLocale = vars.locales.en-us;
  pkgs-nur = pkgs.extend inputs.nur.overlays.default;
in
{
  config = lib.mkIf enableModule {
    programs.firefox = {
      enable = true;
      package = pkgSets.pkgs-nixos-unstable.firefox;
      # 安装界面语言包, 由企业策略从 releases.mozilla.org 按当前 firefox 版本自动装好
      languagePacks = [ locale.bcp47 ];
      # 浏览器策略配置
      policies = {
        # 启动时不检查是否为默认浏览器
        DontCheckDefaultBrowser = true;
        # 始终显示书签工具栏
        DisplayBookmarksToolbar = true;
        # 不创建自带的默认书签
        NoDefaultBookmarks = true;
      };
      # 浏览器偏好设置
      profiles = {
        default = {
          id = 0;
          settings = {
            # 界面语言: 指定首选语言列表
            "intl.locale.requested" = locale.bcp47;
            "intl.locale.matchOS" = false;
            # 网站语言偏好
            "intl.accept_languages" = "${locale.bcp47},${fallbackLocale.bcp47}";
            # 1: 手动配置代理
            # 2: 自动代理配置的 URL
            # 3: 不使用代理服务器
            # 4: 自动检测此网络的代理设置
            # 5: 使用系统代理设置
            "network.proxy.type" = 4;
          };
          # 搜索引擎配置
          search = {
            # 默认搜索引擎
            default = "bing";
            force = true;
            engines = {
              # 隐藏不需要的引擎
              "ddg".metaData.hidden = true;
              "baidu".metaData.hidden = true;
              "google".metaData.hidden = true;
              "perplexity".metaData.hidden = true;
              "wikipedia-zh-CN".metaData.hidden = true;
            };
          };
          # 安装扩展, 详情: https://nur.nix-community.org/repos/rycee/
          extensions.packages = with pkgs-nur.nur.repos.rycee.firefox-addons; [
            # 简约翻译
            kiss-translator
          ];
        };
      };
    };
  };
}
