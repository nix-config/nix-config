{
  lib,
  pkgs,
  opts,
  ...
}:
let
  inherit (pkgs) deviceTrees;
  inherit (opts.hardware.dtb) name;
  vendor = lib.findFirst (
    v: lib.isAttrs deviceTrees.${v} && builtins.hasAttr name deviceTrees.${v}
  ) null (builtins.attrNames deviceTrees);
in
{
  config = lib.mkMerge [
    {
      assertions = lib.optional (name != null) {
        assertion = vendor != null;
        message = "opts.hardware.dtb.name = \"${name}\" 在 pkgs.deviceTrees 中找不到对应板卡";
      };
    }
    (lib.mkIf (vendor != null) {
      hardware.deviceTree = {
        enable = true;
        dtbSource = "${deviceTrees.${vendor}.${name}}/dtbs";
        name = "${vendor}/${name}.dtb";
      };
    })
  ];
}
