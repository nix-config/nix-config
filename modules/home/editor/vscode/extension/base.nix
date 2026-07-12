{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  extensions = opts.editor.vscode.extensions;
  enableModule = lib.elem "base" extensions || lib.elem "all" extensions;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
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
      # 系统监控
      nexmoe.monitor-pro
      # 行号区域预览图片, 颜色等
      kisstkondoros.vscode-gutter-preview
    ];
  };
}
