/*
  功能:
    递归校验 attrs 树的类型并填充默认值
    遍历 schema 的 key:
      - attrs 中存在同名 key 时检查类型, 不匹配则 builtins.warn 警告 (不阻断求值)
      - attrs 中缺失同名 key 时, 若 schema 叶子有 default 则填充默认值
  输入参数:
    prefix: 用于校验错误提示的路径前缀 (递归时自动拼接)
    schema: 嵌套 attrs, 叶子为 { type = lib.types.*; default = ...; }
    attrs: 待校验的 attrs
  返回值:
    填充了默认值后的 attrs, 校验结果通过 builtins.warn 输出
  示例:
    functions.checkAttrs "" {
      foo.enable = {
        type = lib.types.bool;
        default = false;
      };
      bar = {
        type = lib.types.str;
        default = "";
      };
    } { foo.enable = "true"; }
  =>
    evaluation warning: foo.enable expected type bool, but true is string
    { foo.enable = "true"; bar = ""; }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  function =
    prefix: schema: attrs:
    let
      processKey =
        key:
        let
          fullKey = if prefix == "" then key else "${prefix}.${key}";
          schemaVal = schema.${key};
          # 叶子: { type = ...; default = ...; }
          isLeaf = builtins.isAttrs schemaVal && schemaVal ? type && schemaVal ? default;
          # 疑似写漏的叶子: 有 type 但缺 default
          isIncompleteLeaf =
            builtins.isAttrs schemaVal
            && schemaVal ? type
            && !(schemaVal ? default)
            # 排除嵌套 schema 中名为 type 的子 key: schemaVal.type 本身不应是叶子定义
            && !(builtins.isAttrs schemaVal.type && schemaVal.type ? type);
          # 嵌套 schema: 是 attrs 且不是叶子也不是写漏的叶子
          isNested = builtins.isAttrs schemaVal && !isLeaf && !isIncompleteLeaf;
          result =
            if attrs ? ${key} then
              # key 在用户配置中存在
              let
                val = attrs.${key};
              in
              if isNested then
                # 嵌套节点: 递归校验子 key
                { ${key} = function fullKey schemaVal val; }
              else if isLeaf then
                # 完整叶子: 类型检查, 不匹配则 trace 警告但仍原样返回
                if !(schemaVal.type.check val) then
                  builtins.warn
                    "${fullKey} expected type ${schemaVal.type.name}, but ${toString val} is ${builtins.typeOf val}"
                    { ${key} = val; }
                else
                  let
                    ec = ((schemaVal.type.nestedTypes or { }).elemType or null).check or null;
                  in
                  if
                    ec == null
                    || !(builtins.isList val || builtins.isAttrs val)
                    || !(builtins.any (e: !(ec e)) (if builtins.isList val then val else builtins.attrValues val))
                  then
                    { ${key} = val; }
                  else
                    builtins.warn "${fullKey}: element type mismatch in ${schemaVal.type.name}" { ${key} = val; }
              else
                # 其他 (写漏叶子的 key 存在时丢弃也不报错, 仅靠外层警告)
                { }
            else
            # key 在用户配置中缺失
            if isLeaf then
              # 完整叶子: 填充默认值
              { ${key} = schemaVal.default; }
            else if isNested then
              # 嵌套节点: 以空 attrs 递归, 填充子 key 的默认值
              { ${key} = function fullKey schemaVal { }; }
            else
              # 其他 (写漏叶子没有 default 可填, 不填充)
              { };
        in
        if isIncompleteLeaf then
          # 无论 key 是否存在/走哪个分支, 只要 schema 定义有 type 缺 default 就警告
          builtins.warn "${fullKey} missing default" result
        else
          result;
      filled = lib.foldl' (acc: key: lib.mergeAttrs acc (processKey key)) { } (builtins.attrNames schema);
    in
    lib.mergeAttrs attrs filled;
in
function
