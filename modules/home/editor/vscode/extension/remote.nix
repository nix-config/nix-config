{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  inherit (opts.editor.vscode) enabledExtensions;
  enableModule = (lib.elem "remote" enabledExtensions) || (lib.elem "all" enabledExtensions);
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # 开发容器支持
      ms-azuretools.vscode-containers
      # Docker 镜像, 容器管理
      ms-azuretools.vscode-docker
      # 通过 SSH 连接远程主机
      ms-vscode-remote.remote-ssh
      # SSH 配置编辑支持
      ms-vscode-remote.remote-ssh-edit
      # 远程资源管理器视图
      ms-vscode.remote-explorer
    ];
  };
}
