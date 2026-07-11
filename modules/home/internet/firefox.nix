{
  lib,
  pkgs,
  opts,
  inputs,
  pkgSets,
  ...
}:
let
  desktopTypeIsNone = (opts.display.desktopType == "none");
  enableModule = opts.internet.firefox.enable && (!desktopTypeIsNone);
  locale = opts.i18n.locale;
  nur = inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  inherit (nur.repos.rycee.firefox-addons) kiss-translator;
in
{
  config = lib.mkIf enableModule {
    programs = {
      firefox = {
        # 启用 Firefox 浏览器
        enable = true;
        package = pkgSets.pkgs-nixos-unstable.firefox;
        # 浏览器策略配置
        policies = {
          # 启动时不检查是否为默认浏览器
          DontCheckDefaultBrowser = true;
          # 始终显示书签工具栏
          DisplayBookmarksToolbar = true;
          # 不创建自带的默认书签
          NoDefaultBookmarks = true;
          # 受控书签
          ManagedBookmarks = [
            {
              name = "AI";
              children = [
                {
                  name = "DeepSeek";
                  url = "https://chat.deepseek.com/";
                }
                {
                  name = "Kimi";
                  url = "https://www.kimi.com/";
                }
              ];
            }
            {
              name = "视频";
              children = [
                {
                  name = "bilibili";
                  url = "https://www.bilibili.com/";
                }
              ];
            }
            {
              name = "工具";
              children = [
                {
                  name = "Nix";
                  children = [
                    {
                      name = "NixOS Search";
                      url = "https://search.nixos.org/";
                    }
                    {
                      name = "Home Manager Options Search";
                      url = "https://home-manager-options.extranix.com/";
                    }
                    {
                      name = "NUR";
                      url = "https://nur.nix-community.org/";
                    }
                  ];
                }
              ];
            }
          ];
        };
        # 浏览器偏好设置
        profiles = {
          default = {
            id = 0;
            settings = {
              # 强制使用操作系统语言
              "intl.locale.requested" = locale;
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
            # 安装扩展
            extensions.packages = [
              # 详情: https://nur.nix-community.org/repos/rycee/
              # 简约翻译
              kiss-translator
            ];
          };
        };
      };
    };
  };
}
