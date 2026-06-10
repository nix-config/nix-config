{
  lib,
  pkgs,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.service.openlist or { };
  finallyEnable = cfg.enable or false;
in
{
  # 首次启动执行:
  # sudo journalctl -u alist --no-pager | grep -i "initial password"
  # 获取初始随机密码后登陆, 在 Web 界面设置密码
  imports = [
    inputs.nur-moraxyc.nixosModules.alist
  ];
  config = lib.mkIf finallyEnable {
    sops.secrets."alist/jwt_secret" = {
      sopsFile = ../../../secrets/alist.yaml;
      format = "yaml";
      owner = "alist";
      group = "alist";
      mode = "0400";
    };
    sops.templates."alist-jwt_secret" = {
      content = ''
        ${config.sops.placeholder."alist/jwt_secret"}
      '';
      owner = "alist";
      group = "alist";
      mode = "0400";
    };
    services.alist = {
      enable = true;
      package = pkgs.openlist;
      settings.jwt_secret._secret = config.sops.templates."alist-jwt_secret".path;
    };
    systemd.services.alist.path = [ pkgs.ffmpeg-headless ];
  };
}
