{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  inherit (opts.editor.vscode) enabledExtensions;
  enableModule = (lib.elem "python" enabledExtensions) || (lib.elem "all" enabledExtensions);
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # 语言服务器
      astral-sh.ty
      # 代码格式化
      charliermarsh.ruff
      # 调试器
      ms-python.debugpy
      # 语法支持
      ms-python.python
      # 环境检测
      ms-python.vscode-python-envs
    ];
  };
}
