{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  config = {
    # 将 SSH 密钥自动导入为 age 密钥(默认行为)
    # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    # 确保所有服务都在 sops-nix 之后启动(默认行为)
    # systemd.targets.multi-user.wants = [ "sops-nix.service" ];
  };
}
