{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions.python or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        # Python 语法支持
        ms-python.python
        # Python 调试器
        ms-python.debugpy
        # Python 高性能语言服务器
        ms-python.vscode-pylance
        # Black 代码格式化工具
        ms-python.black-formatter
        # Jinja 语法支持
        wholroyd.jinja
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # Python 环境管理
          name = "vscode-python-envs";
          publisher = "ms-python";
          version = "1.33.2026060801";
          sha256 = "sha256-ujk/TNJPeFD6+CQUBP0Zw1ZtmtLWqfMUcdCNA4XYj5I=";
        }
        {
          # Manim 动画侧边实时预览
          name = "manim-sideview";
          publisher = "Rickaym";
          version = "0.3.1";
          sha256 = "sha256-TZs0KCBfVbueu6AGdP1OL8DTQkWiPWh1zcFBdHU+Gwc=";
        }
      ];
  };
}
