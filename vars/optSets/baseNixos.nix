inputs: {
  # 提供 NixOS 必选项
  cli = {
    dix.enable = true;
    nix.enable = true;
  };
  hardware = {
    disk.enable = true;
    networking.enable = true;
    boot-loader.enable = true;
  };
  environment.i18n.enable = true;
}
