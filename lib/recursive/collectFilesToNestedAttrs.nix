/*
  功能:
    递归收集指定目录下除 dir 自身的 default.nix 外的所有 .nix 文件为嵌套 attrs
  输入参数:
    dir: 目标目录路径 (string 或 path)
  返回值:
    嵌套 attrs, 每个 .nix 文件的路径层次对应 attr 层次:
      - dir/foo.nix         => { foo = ...; }
      - dir/bar/baz.nix     => { bar.baz = ...; }
      - dir/sub/dir/qux.nix => { sub.dir.qux = ...; }
      - dir/sub/default.nix => { sub.default = ...; }
  示例:
    functions.recursive.collectFilesToNestedAttrs ./.
  =>
    { foo = ...; bar.baz = ...; sub.dir.qux = ...; sub.default = ...; }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  function =
    dir:
    let
      allFiles = (import ./collectFilesToList.nix inputs) (name: true) dir;
      # 排除 dir 自身的 default.nix, 防止递归自导入
      paths = builtins.filter (p: p != toString dir + "/default.nix") allFiles;
      # 将绝对路径转换为相对于 dir 的路径 (如 "/foo/bar/a.nix" -> "a.nix")
      relPath = fullPath: lib.removePrefix (toString dir + "/") (toString fullPath);
      # 将相对路径拆分为 attr 路径 (如 "sub/dir/file.nix" -> [ "sub" "dir" "file" ])
      toAttrPath = rel: lib.splitString "/" (lib.removeSuffix ".nix" rel);
      # 为每个文件生成一个局部 attrs, 例如 { sub.dir.file = import ...; }
      fileAttrs = map (
        file:
        let
          rel = relPath file;
          attrPath = toAttrPath rel;
        in
        if attrPath == [ ] then
          throw "functions.recursive.collectFilesToNestedAttrs: empty attribute path for file ${toString file}"
        else
          lib.setAttrByPath attrPath (import file inputs)
      ) paths;
    in
    # 深度合并所有局部 attrs, 得到完整的嵌套 attrs
    (import ./mergeAttrsList.nix inputs) fileAttrs;
in
function
