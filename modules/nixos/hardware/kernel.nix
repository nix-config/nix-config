{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  # 从独立文件中导入内核构建函数, 传入 inputs 供其内部使用
  mkKernelPackage = import ../../../functions/mkKernelPackage.nix inputs;
  # 获取用户配置的内核列表, 若未定义则默认为空列表
  cfg = opts.hardware.kernel or [ ];
  finallyEnable = cfg != [ ];
  # 遍历每个内核配置, 构建出 { name, kernel } 属性的条目列表
  entries = map (k: {
    # 保留名称用于后续 specialisation 命名
    name = k.name;
    kernel =
      if k ? packages then
        # 直接使用包
        k.packages
      else
        # 去掉 name 字段 (mkKernelPackage 不需要), 补上 pkgs 后调用内核构建函数
        mkKernelPackage (removeAttrs k [ "name" ] // { inherit pkgs; });
  }) cfg;
in
{
  config = lib.mkIf finallyEnable {
    # 将列表中的第一个内核设为当前系统的默认内核包 (mkDefault 允许用户覆盖)
    boot.kernelPackages = lib.mkDefault (builtins.head entries).kernel;
    # 将剩余内核配置为 specialisation, 这样在启动时可选不同的内核
    specialisation = builtins.listToAttrs (
      map (e: {
        name = e.name;
        value = {
          # mkForce 强制覆盖该 specialisation 的内核包
          configuration.boot.kernelPackages = lib.mkForce e.kernel;
        };
      }) (builtins.tail entries) # 跳过第一个 (已设为默认)
    );
  };
}
