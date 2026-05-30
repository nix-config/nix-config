/*
  功能:
    递归导入指定目录下的所有 .nix 文件(除 default.nix 外)为模块
  输入参数:
    dir: 目标目录路径(字符串或路径类型)
  返回值:
    一个模块列表
*/
inputs:
let
  # 导入辅助函数
  getDirNixFiles = import ./getDirNixFiles.nix inputs;
  importFilesForModules =
    dir:
    let
      # 获取 dir 下所有 .nix 文件的完整路径列表
      allModulePaths = getDirNixFiles dir;
    in
    # 逐个 import 并返回结果列表
    map (path: import path) allModulePaths;
in
importFilesForModules
