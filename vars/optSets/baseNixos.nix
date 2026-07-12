{
  ...
}:
{
  # 提供 NixOS 必选项
  cli.nix.enable = true;
  hardware = {
    disk.enable = true;
    kernel.enable = true;
    graphics.enable = true;
    networking.enable = true;
    boot-loader.enable = true;
  };
  environment.i18n.enable = true;
}
