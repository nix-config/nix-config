{
  inputs,
  functions,
  ...
}:
let
  system = "x86_64-linux";
  inherit (functions.mk.pkgSets system inputs) pkgs;
in
{
  ${system}.default = pkgs.mkShell {
    packages = with pkgs; [
      # just lsp
      just-lsp
      # nix lsp
      nixd
      # nix 文件格式化
      nixfmt
      # nix 多文件批量格式化
      nixfmt-tree
      # nix 日志渲染包装
      nix-output-monitor
      # 密钥管理
      sops
    ];
  };
}
