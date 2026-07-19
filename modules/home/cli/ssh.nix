{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.sops-nix.enable;
  inherit (opts.cli.ssh) enableSshSecrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  config = lib.mkIf enableModule {
    sops.secrets = lib.mkMerge [
      (lib.genAttrs (map (n: "ssh/${n}") enableSshSecrets) (name: {
        sopsFile = ../../../secrets/ssh/${baseNameOf name}.enc;
        format = "binary";
        mode = "0600";
        path = "${config.home.homeDirectory}/.ssh/${baseNameOf name}";
      }))
      {
        "ssh/config" = {
          sopsFile = ../../../secrets/ssh/config.enc;
          format = "binary";
          mode = "0600";
        };
      }
    ];
    programs.ssh = {
      enable = true;
      # 导入解密后的配置
      includes = [ config.sops.secrets."ssh/config".path ];
      # 禁用默认配置
      enableDefaultConfig = false;
    };
  };
}
