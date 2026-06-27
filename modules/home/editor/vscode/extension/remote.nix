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
  cfg = opts.editor.vscode.extensions.remote or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
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
      # YAML 语法支持
      redhat.vscode-yaml
    ];
  };
}
