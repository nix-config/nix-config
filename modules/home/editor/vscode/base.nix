{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions.base or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        # 中文界面语言包
        ms-ceintl.vscode-language-pack-zh-hans
        # Material 风格图标主题
        pkief.material-icon-theme
        # Prettier 多语言格式化
        esbenp.prettier-vscode
        # Git 提交图可视化
        mhutchie.git-graph
        # 代码翻译
        w88975.code-translate
        # 行内错误高亮
        usernamehw.errorlens
        # 缩进层次彩虹色标识
        oderwat.indent-rainbow
        # 文件路径智能补全
        christian-kohler.path-intellisense
        # 生成美观的代码截图
        adpyke.codesnap
        # 十六进制编辑器
        ms-vscode.hexeditor
        # just 语言支持
        nefrob.vscode-just-syntax
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # 系统监控
          name = "monitor-pro";
          publisher = "nexmoe";
          version = "0.7.5";
          sha256 = "sha256-Q38GkZyouXg58YFvrlaoT9Km0wGd8VFPPSPfvaFE1cs=";
        }
        {
          # 行号区域预览图片, 颜色等
          name = "vscode-gutter-preview";
          publisher = "kisstkondoros";
          version = "0.32.2";
          sha256 = "sha256-JIr4UGuwy9Z5oH8D8elGMBGP8s40pYLCEZGmJAO5Ga0=";
        }
      ];
  };
}
