{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  extensions = opts.editor.vscode.extensions;
  enableModule = lib.elem "python" extensions || lib.elem "all" extensions;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
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
