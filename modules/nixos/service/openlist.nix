{
  lib,
  pkgs,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.sops-nix.enable;
  # TODO: nixpkgs/openlist 分支 (PR #543514), 待合入上游 nixpkgs/master
  openlistModule = "${inputs.nixpkgs-openlist}/nixos/modules/services/web-apps/openlist.nix";
in
{
  # 首次启动执行:
  # sudo journalctl -u openlist --no-pager | grep -i "initial password"
  # 获取初始随机密码后登陆, 在 Web 界面设置密码
  imports = [
    openlistModule
    inputs.sops-nix.nixosModules.sops
  ];
  config = lib.mkIf enableModule {
    # 手册配置 (模块来自外部分支, 上游无 openlist 锚点与选项文档)
    documentation.nixos = {
      extraModules = [ openlistModule ];
      checkRedirects = false;
    };
    sops.secrets."openlist/jwt-secret" = {
      sopsFile = ../../../secrets/openlist/jwt-secret.enc;
      format = "binary";
      owner = "openlist";
      group = "openlist";
      mode = "0400";
    };
    services.openlist = {
      enable = true;
      extraPackages = [
        pkgs.ffmpeg-headless
      ];
      settings = {
        scheme.address = "0.0.0.0";
        jwt_secret._secret = config.sops.secrets."openlist/jwt-secret".path;
      };
    };
  };
}
