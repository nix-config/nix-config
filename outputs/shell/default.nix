{
  lib,
  inputs,
  functions,
}:
let
  system = "x86_64-linux";
  pkgSets = functions.mk.pkgSets system inputs;
  tools = with pkgSets.pkgs; [
    just-lsp # just lsp
    nixd # nix lsp
    nixfmt # nix 文件格式化
    nixfmt-tree # nix 多文件批量格式化
    nix-output-monitor # nix 日志渲染包装
    sops # 密钥管理
  ];
in
{
  ${system}.default = pkgSets.pkgs.mkShell {
    packages = tools;
    # 通过 lib.getExe 取可执行路径, 通过 lib.getName 显示包名
    shellHook = lib.concatMapStringsSep "\n" (tool: ''
      echo "${lib.getName tool} version: $(${lib.getExe tool} --version 2>&1 | head -n1 | grep -oE '[0-9]+(\.[0-9]+)+' | head -n1)"
    '') tools;
  };
}
