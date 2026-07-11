{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.openlist.enable;
in
{
  # 首次启动执行:
  # sudo journalctl -u openlist --no-pager | grep -i "initial password"
  # 获取初始随机密码后登陆, 在 Web 界面设置密码
  imports = [
    inputs.nur-knightfemale.nixosModules.openlist
  ];
  config = lib.mkIf enableModule {
    sops.secrets."openlist/jwt-secret" = {
      sopsFile = ../../../secrets/openlist/jwt-secret.enc;
      format = "binary";
      owner = "openlist";
      group = "openlist";
      mode = "0400";
    };
    services.openlist = {
      enable = true;
      settings = {
        scheme.address = "0.0.0.0";
        jwt_secret._secret = config.sops.secrets."openlist/jwt-secret".path;
      };
    };
  };
}
