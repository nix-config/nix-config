/*
  功能:
    mapAttrs 的变体, 同时支持操作 key 和 value
  输入参数:
    f: (name: string) => (value: any) => { name: string, value: any }
    attrs: 要变换的 attrs
  返回值:
    经过 f 映射后的新 attrs
  示例:
    functions.mapAttrsPrime
      (name: value: { name = name + "1"; value = value + 1; })
      { a = 1; b = 2; }
  =>
    { a1 = 2; b2 = 3; }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  function = f: attrs: builtins.listToAttrs (lib.mapAttrsToList f attrs);
in
function
