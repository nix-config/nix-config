{
  lib,
  opts,
  config,
  ...
}:
let
  cfg = opts.cli.nix or { };
  substituters = cfg.substituters or [ ];
  trusted-substituters = cfg.trusted-substituters or [ ];
  trusted-public-keys = cfg.trusted-public-keys or [ ];
  enableSopsNix = opts.service.sops-nix.enable or false;
in
{
  sops.secrets = {
    "nix/secret-key" = lib.mkIf enableSopsNix {
      sopsFile = ../../../secrets/nix/secret-key.enc;
      format = "binary";
      owner = "root";
      group = "root";
      mode = "0600";
    };
    "nix/extra-options.conf" = lib.mkIf enableSopsNix {
      sopsFile = ../../../secrets/nix/extra-options.ini;
      format = "ini";
      # 只有 root 和 sudo 用户可读
      owner = "root";
      group = "wheel";
      mode = "0440";
    };
  };
  nix = {
    settings = {
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
      secret-key-files = lib.mkIf enableSopsNix [
        config.sops.secrets."nix/secret-key".path
      ];
    };
    # 通过 !include 包含运行时生成的配置文件(宽容模式, 如果指定的文件不存在 Nix 会忽略该指令)
    extraOptions = lib.mkIf enableSopsNix "!include ${
      config.sops.secrets."nix/extra-options.conf".path
    }";
  };
}
