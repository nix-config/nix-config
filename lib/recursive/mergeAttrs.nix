/*
  功能:
    深度递归合并两个 attrs
    当左右两侧的 key 都是 attrs 且非 derivation 时, 递归合并
    当左右两侧的 key 都是 list 时, 去重合并
    否则右侧的 key 覆盖左侧的 key
  输入参数:
    lhs: 左侧 attrs (低优先级)
    rhs: 右侧 attrs (高优先级)
  返回值:
    合并后的新 attrs
  示例:
    functions.recursive.mergeAttrs
      { a = 1; b = 2; d = [ 1 2 ]; e = { foo.bar = true; foo.baz = "baz"; }; }
      { b = 3; c = 4; d = [ 2 3 ]; e = { foo.baz = ""; }; }
  =>
    { a = 1; b = 3; c = 4; d = [ 1 2 3 ]; e = { foo.bar = true; foo.baz = ""; } }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  function =
    lhs: rhs:
    lib.mergeAttrsList [
      lhs
      (builtins.mapAttrs (
        rName: rValue:
        let
          lValue = lhs.${rName} or null;
        in
        if
          builtins.isAttrs lValue
          && builtins.isAttrs rValue
          && (lValue.type or null) != "derivation"
          && (rValue.type or null) != "derivation"
        then
          function lValue rValue
        else if builtins.isList lValue && builtins.isList rValue then
          lib.unique (lValue ++ rValue)
        else
          rValue
      ) rhs)
    ];
in
function
