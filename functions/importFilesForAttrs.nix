/*
  功能:
    递归导入指定目录下的所有 .nix 文件(除 default.nix 外)为属性集
  输入参数:
    dir: 目标目录路径(字符串或路径类型)
  返回值:
    一个嵌套属性集, 其中每个属性对应一个 .nix 文件的导入结果。
    属性键的层级结构由文件相对于 dir 的路径决定:
      - 若文件位于 dir/foo.nix, 则生成属性 { foo = <import 结果>; }
      - 若文件位于 dir/bar/baz.nix, 则生成属性 { bar.baz = <import 结果>; }
      - 若文件位于 dir/sub/dir/qux.nix, 则生成属性 { sub.dir.qux = <import 结果>; }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  # 导入辅助函数
  getDirNixFiles = import ./getDirNixFiles.nix inputs;
  importFilesForAttrs =
    dir:
    let
      allFiles = getDirNixFiles dir;
      # 健壮的相对路径计算: 将 dir 的字符串表示规范化, 并确保以 '/' 结尾(除非是根目录)
      dirStr = toString dir;
      baseDir =
        if dirStr == "/" then
          "/"
        else if lib.hasSuffix "/" dirStr then
          dirStr
        else
          dirStr + "/";
      # 获取相对于 baseDir 的路径, 并去除可能的前导 '/'
      relPath =
        fullPath:
        let
          fullStr = toString fullPath;
          # 先去掉规范化的目录前缀
          withoutBase = lib.removePrefix baseDir fullStr;
          # 再去除可能残留的前导 '/'
          rel =
            if lib.hasPrefix "/" withoutBase then
              builtins.substring 1 (builtins.stringLength withoutBase - 1) withoutBase
            else
              withoutBase;
        in
        rel;
      # 将相对路径(如 "sub/dir/file.nix")转换为属性路径列表(如 ["sub" "dir" "file"])
      toAttrPath =
        rel:
        let
          withoutSuffix = lib.removeSuffix ".nix" rel;
          # 按 '/' 拆分, 并过滤掉空字符串(处理连续的 '/')
          parts = builtins.filter (s: builtins.typeOf s == "string" && s != "") (
            builtins.split "/" withoutSuffix
          );
        in
        parts;
      # 为每个文件生成一个局部属性集, 例如 { sub.dir.file = import ...; }
      fileAttrs = map (
        file:
        let
          rel = relPath file;
          attrPath = toAttrPath rel;
        in
        if attrPath == [ ] then
          throw "importFilesForAttrs: empty attribute path for file ${toString file}"
        else
          lib.setAttrByPath attrPath (import file inputs)
      ) allFiles;
    in
    # 深度合并所有局部属性集, 得到完整的嵌套属性集
    builtins.foldl' lib.recursiveUpdate { } fileAttrs;
in
importFilesForAttrs
