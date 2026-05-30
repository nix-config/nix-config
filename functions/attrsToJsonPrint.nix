/*
  功能:
    用于调试的辅助函数, 该函数在求值时会通过 builtins.trace 打印输入值的 JSON 表示
    并原样返回该值, 便于在 Nix 表达式中插入调试输出而不改变原有逻辑
  输入参数:
    attrs: 任意 Nix 值
  返回值:
    原输入值 attrs, 其类型和内容完全不变
*/
inputs:
let
  attrsToJsonPrint = attrs: builtins.trace (builtins.toJSON attrs) attrs;
in
attrsToJsonPrint
