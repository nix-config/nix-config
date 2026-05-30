/*
  功能:
    深度递归合并两个属性集
    当左右两边某 key 对应的值都是 attrs 时, 递归合并, 否则右侧覆盖左侧
  输入参数:
    left: 左侧属性集(低优先级)
    right: 右侧属性集(高优先级)
  返回值:
    合并后的新属性集
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  deepMergeAttrs =
    left: right:
    if builtins.isAttrs left && builtins.isAttrs right then
      # 两边都是属性集: 遍历 right 的每个属性, 逐个与 left 递归合并
      lib.foldl' (
        acc: name:
        if builtins.hasAttr name left then
          # left 中也存在该 key: 递归调用 deepMergeAttrs 合并子属性集
          acc // { ${name} = deepMergeAttrs left.${name} right.${name}; }
        else
          # left 中不存在该 key: 直接取 right 的值
          acc // { ${name} = right.${name}; }
      ) left (builtins.attrNames right)
    else
      # 至少有一边不是属性集: 直接返回右侧值
      right;
in
deepMergeAttrs
