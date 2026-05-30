/*
  功能:
    使用 deepMergeAttrs 将属性列表折叠合并为单个属性集
    从左到右依次合并, 后者的值覆盖前者(深度递归合并)
  输入参数:
    attrsList: 待合并的属性列表, 按从左到右顺序逐一折叠合并
  返回值:
    合并后的新属性集
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  # 导入辅助函数
  deepMergeAttrs = import ./deepMergeAttrs.nix inputs;
  mergeAttrsList = attrsList: lib.foldl' (acc: item: deepMergeAttrs acc item) { } attrsList;
in
mergeAttrsList
