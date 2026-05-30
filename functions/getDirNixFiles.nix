/*
  功能:
    递归获取指定目录下(包括所有后代子目录)所有 .nix 文件(除 default.nix 外)的完整路径列表
  输入参数:
    dir: 目标目录路径(字符串或路径类型)
  返回值:
    一个包含文件完整完整路径(字符串)的列表
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  getDirNixFiles =
    dir:
    let
      # 读取目录内容
      content = builtins.readDir dir;
      # 定义递归处理每个条目的函数
      processEntry =
        name: type:
        let
          fullPath = dir + "/${name}";
        in
        if
          # 是文件(regular)
          type == "regular"
          # 后缀为 .nix
          && lib.hasSuffix ".nix" name
          # 非 default.nix
          && name != "default.nix"
        then
          [ fullPath ]
        else if type == "directory" then
          getDirNixFiles fullPath
        else
          [ ];
    in
    # 合并所有条目返回的路径列表
    builtins.concatLists (lib.mapAttrsToList processEntry content);
in
getDirNixFiles
