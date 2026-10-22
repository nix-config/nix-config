/*
  功能:
    收集指定目录下除 default.nix 自身的所有 .nix 文件, 经 filter 过滤后导入为模块值
    返回已求值的模块 list
  输入参数:
    dir: 目标目录路径 (string 或 path)
    filter: (path: string) => bool, 返回 false 的文件不被导入
  返回值:
    模块值 list, 可直接用于 imports 属性
  示例:
    functions.recursive.importFilesToModules ./. (path: true)
  =>
    [ <模块值> <模块值> ... ]
*/
inputs:
let
  function =
    dir: filter:
    let
      allFiles = (import ./collectFilesToList.nix inputs) (name: true) dir;
      selfDefault = toString dir + "/default.nix";
      paths = builtins.filter (p: p != selfDefault) allFiles;
    in
    map (path: import path) (builtins.filter filter paths);
in
function
