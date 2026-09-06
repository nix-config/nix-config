{
  lib,
  pkgs,
  opts,
  inputs,
  ...
}:
let
  inherit (opts.hardware.dtb) name;
  deviceTrees = inputs.nur-knightfemale.legacyPackages.${pkgs.stdenv.hostPlatform.system}.deviceTree;
  deviceTree = if name != null then deviceTrees.${name} else null;
in
{
  config = lib.mkIf (deviceTree != null) {
    # 指定板卡专用 DTB
    hardware = { inherit deviceTree; };
  };
}
