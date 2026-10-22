/*
  功能:
    根据基础 string 和数量生成带序号后缀的 string list
    如果数量 <= 1 则不加后缀
    用于例如生成多实例带序号的名称场景
  输入参数:
    str: 基础 string
    count: 数量 (int), 决定生成多少个名称
  返回值:
    string list
  示例:
    functions.mk.numberedStrings "name" 3
  =>
    [ "name-1" "name-2" "name-3" ]
*/
inputs:
let
  function =
    str: count:
    if count <= 1 then [ str ] else builtins.genList (i: "${str}-${toString (i + 1)}") count;
in
function
