{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  inherit (opts.hardware.kernel) name configs;
  kernels = inputs.nur-knightfemale.legacyPackages.${pkgs.stdenv.hostPlatform.system}.kernelPackages;
  kernelPkg = if name != null then pkgs.linuxPackagesFor kernels.${name} else null;
in
{
  config = lib.mkMerge [
    (lib.mkIf (kernelPkg != null) {
      boot.kernelPackages = kernelPkg;
    })
    (lib.mkIf (configs != { }) {
      # 通过 structuredExtraConfig 将 kernelConfig 注入内核选项
      boot.kernelPatches = [
        {
          name = "extra-kernel-config";
          patch = null;
          structuredExtraConfig = lib.mapAttrs (_: v: lib.kernel."${v}") configs;
        }
      ];
    })
  ];
}
