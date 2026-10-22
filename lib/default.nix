/*
  函数库入口：显式装配，不再递归扫描目录。
  新增函数时在此登记；flakes 的 flake.functions 与 perSystem 的
  _module.args.functions 都从这里取值。
*/
inputs:
let
  call = file: import file inputs;
in
{
  normalizeAttrs = call ./normalizeAttrs.nix;
  mapAttrsPrime = call ./mapAttrsPrime.nix;

  mk = {
    pkgSets = call ./mk/pkgSets.nix;
    numberedStrings = call ./mk/numberedStrings.nix;
  };

  recursive = {
    collectDefaultFilesToAttrs = call ./recursive/collectDefaultFilesToAttrs.nix;
    collectFilesToList = call ./recursive/collectFilesToList.nix;
    collectFilesToNestedAttrs = call ./recursive/collectFilesToNestedAttrs.nix;
    importFilesToModules = call ./recursive/importFilesToModules.nix;
    mergeAttrs = call ./recursive/mergeAttrs.nix;
    mergeAttrsList = call ./recursive/mergeAttrsList.nix;
  };
}
