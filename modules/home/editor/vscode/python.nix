{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
  cfg = opts.editor.vscode.extensions.python or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
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
      # Python 环境管理
      ms-python.vscode-python-envs
      # Manim 动画侧边实时预览
      rickaym.manim-sideview
    ];
  };
}
