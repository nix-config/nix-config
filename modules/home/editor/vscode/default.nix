{
  lib,
  pkgs,
  opts,
  inputs,
  config,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
  configPath = "${opts.nixConfigPath}/modules/home/editor/vscode/config";
in
{
  config = lib.mkIf enableModule {
    programs.vscode = {
      enable = true;
      profiles.default.extensions = with vscode-marketplace; [
        # 路径补全
        christian-kohler.path-intellisense
        # 文件预览
        cweijan.vscode-office
        # 通用格式化
        esbenp.prettier-vscode
        # 图片预览
        kisstkondoros.vscode-gutter-preview
        # 系统监控
        nexmoe.monitor-pro
        # Direnv 支持
        mkhl.direnv
        # 中文界面
        ms-ceintl.vscode-language-pack-zh-hans
        # 缩进颜色标识
        oderwat.indent-rainbow
        # Material 图标主题
        pkief.material-icon-theme
        # 错误高亮
        usernamehw.errorlens
        # 代码翻译
        w88975.code-translate
      ];
    };
    home.file = {
      ".vscode/argv.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/argv.json";
        force = true;
      };
      ".config/Code/User/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/settings.json";
        force = true;
      };
    };
  };
}
