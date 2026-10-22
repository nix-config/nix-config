/*
  功能:
    递归收集指定目录下通过 filter 筛选后的 .nix 文件路径 list
  输入参数:
    filter: (name: string) => bool
    dir: 目标目录路径 (string 或 path)
  返回值:
    包含文件路径 string 的 list
  示例:
    functions.recursive.collectFilesToList (name: true) /foo
  =>
    [ "/foo/a.nix" "/foo/default.nix" "/foo/sub/b.nix" ]
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  function =
    filter: dir:
    builtins.catAttrs "path" (
      builtins.genericClosure {
        startSet = [
          {
            key = toString dir;
            dir = toString dir;
          }
        ];
        operator =
          { dir, ... }:
          if dir == null then
            [ ]
          else
            let
              entries = builtins.readDir dir;
            in
            builtins.concatLists (
              map (
                name:
                let
                  path = dir + "/${name}";
                  type = entries.${name};
                in
                # .nix 文件: catAttrs 收集, dir=null 阻止再展开
                if type == "regular" && lib.hasSuffix ".nix" name && filter name then
                  [
                    {
                      key = toString path;
                      inherit path;
                      dir = null;
                    }
                  ]
                # 子目录: catAttrs 不收集, operator 继续展开
                else if type == "directory" then
                  [
                    {
                      key = toString path;
                      dir = path;
                    }
                  ]
                # 无关条目: [ ], concatLists 自动清除
                else
                  [ ]
              ) (builtins.attrNames entries)
            );
      }
    );
in
function
