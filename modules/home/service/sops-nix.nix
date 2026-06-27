{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  cfg = opts.service.sops-nix or { };
  finallyEnable = cfg.enable or false;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  config = lib.mkIf finallyEnable {
    # 将 SSH 密钥自动导入为 age 密钥
    sops.age.sshKeyPaths = [
      "${config.home.homeDirectory}/.ssh/id_ed25519"
    ];
  };
}
