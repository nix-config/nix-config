{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.cli.nix;
  substituters = cfg.substituters;
  trusted-substituters = cfg.trusted-substituters;
  trusted-public-keys = cfg.trusted-public-keys;
  sopsNixIsEnabled = opts.service.sops-nix.enable;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  config = lib.mkMerge [
    {
      nix.settings = {
        # 源配置
        inherit substituters;
        inherit trusted-substituters;
        inherit trusted-public-keys;
        # 启用实验性功能
        experimental-features = [
          # nix 命令增强
          "nix-command"
          # flakes 支持
          "flakes"
        ];
        trusted-users = [
          # 默认已开启 "root"
          "@wheel"
        ];
      };
    }
    (lib.mkIf sopsNixIsEnabled {
      sops.secrets = {
        "nix/secret-key" = {
          sopsFile = ../../../secrets/nix/secret-key.enc;
          format = "binary";
          owner = "root";
          group = "root";
          mode = "0600";
        };
        "nix/extra-options.conf" = {
          sopsFile = ../../../secrets/nix/extra-options.ini;
          format = "ini";
          # 只有 root 和 sudo 用户可读
          owner = "root";
          group = "wheel";
          mode = "0440";
        };
      };
      nix = {
        settings.secret-key-files = [
          config.sops.secrets."nix/secret-key".path
        ];
        # 通过 !include 包含运行时生成的配置文件(宽容模式, 如果指定的文件不存在 Nix 会忽略该指令)
        extraOptions = "!include ${config.sops.secrets."nix/extra-options.conf".path}";
      };
    })
  ];
}
