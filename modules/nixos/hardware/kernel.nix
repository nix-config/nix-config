{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  # 获取用户配置的内核列表, 若未定义则默认为空列表
  cfg = opts.hardware.kernel or [ ];
  finallyEnable = cfg != [ ];
  kernels = inputs.nur-knightfemale.packages.${pkgs.stdenv.hostPlatform.system};
  # 遍历每个内核配置, 构建出 { name, kernel } 属性的条目列表
  entries = map (name: {
    inherit name;
    kernel = pkgs.linuxPackagesFor kernels.${name};
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
