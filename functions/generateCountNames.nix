/*
  功能:
    根据基础名称和数量生成名称列表
    用于生成多实例场景, 自动生成带序号的名称
  输入参数:
    baseName: 基础名称
    count: 数量(整数), 决定生成多少个名称
  返回值:
    字符串列表
*/
inputs:
let
  generateCountNames =
    baseName: count:
    if count <= 1 then
      # 数量小于等于 1 时: 直接返回包含基础名称的单元素列表
      [ baseName ]
    else
      # 数量大于 1 时: 生成 baseName-1, baseName-2, ..., baseName-count 的列表
      builtins.genList (i: "${baseName}-${toString (i + 1)}") count;
in
generateCountNames
