{
  pkgs,
  ...
}:
{
  config = {
    # 自动挂载 U 盘
    environment.systemPackages = with pkgs; [
      udiskie
    ];
    services.udisks2.enable = true;
  };
}
