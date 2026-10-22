/*
  功能:
    递归收集指定目录下除 dir 自身的 default.nix 外的所有 default.nix 文件为嵌套 attrs
  输入参数:
    dir: 目标目录路径 (string 或 path)
    extraArgs: 传递给每个 default.nix 的 attrs
  返回值:
    深度合并后的 attrs
  示例:
    functions.recursive.collectDefaultFilesToAttrs /pkgs {
      inherit lib pkgs inputs system functions;
    }
  =>
    { foo = drv1; bar = drv2; }
*/
inputs:
let
  function =
    dir: extraArgs:
    let
      # 递归查找所有 default.nix
      allDefaults = (import ./collectFilesToList.nix inputs) (name: name == "default.nix") dir;
      # 排除 dir 自身的 default.nix, 防止递归自导入
      paths = builtins.filter (p: p != toString dir + "/default.nix") allDefaults;
      imported = map (path: import path extraArgs) paths;
    in
    (import ./mergeAttrsList.nix inputs) imported;
in
function
