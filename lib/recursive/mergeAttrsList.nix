/*
  功能:
    深度递归合并两个 attrs list
    将列表中的多个 attrs 依次合并:
      当左右两侧的 key 都是 attrs 且非 derivation 时, 递归合并
      当左右两侧的 key 都是 list 时, 去重合并
      否则右侧的 key 覆盖左侧的 key
  输入参数:
    list: attrs 列表 (从左到右优先级递增)
  返回值:
    合并后的新属性集
  示例:
    functions.recursive.mergeAttrsList [
      { a = 1; b = 2; d = [ 1 2 ]; }
      { e = { foo.bar = true; foo.baz = "baz"; }; }
      { b = 3; c = 4; d = [ 2 3 ]; e = { foo.baz = ""; }; }
    ]
  =>
    { a = 1; b = 3; c = 4; d = [ 1 2 3 ]; e = { foo.bar = true; foo.baz = ""; } }
*/
inputs:
let
  function = builtins.foldl' (import ./mergeAttrs.nix inputs) { };
in
function
