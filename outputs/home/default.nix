{
  lib,
  vars,
  inputs,
  functions,
  ...
}:
let
  # 读取目录内容 (返回 { 文件名: 类型; })
  content = builtins.readDir ./.;
  # 筛选出所有符合要求的目录
  userDirs = builtins.attrNames (
    lib.filterAttrs (
      name: type:
      # 是目录
      type == "directory"
      # 存在 opts.nix
      && builtins.pathExists (./. + "/${name}/opts.nix")
    ) content
  );
in
lib.mergeAttrsList (
  map (
    baseName:
    let
      opts = import (./. + "/${baseName}/opts.nix") vars;
      # 从 opts 获取信息
      userCustomOptSets = opts.user.customOptSets or { };
      count = userCustomOptSets.count or 1;
      system = userCustomOptSets.system or "x86_64-linux";
      pkgSets = functions.mk.pkgSets system inputs;
      stateVersion = userCustomOptSets.stateVersion or "26.05";
      userPredefinedOptSetsList = opts.user.predefinedOptSetsList or [ ];
      userOpts = functions.recursive.mergeAttrs (functions.recursive.mergeAttrsList userPredefinedOptSetsList) userCustomOptSets;
      # 根据 count 生成用户名称列表
      userNames = functions.mk.numberedStrings baseName count;
    in
    builtins.listToAttrs (
      map (
        username:
        let
          userOptsNormalized = functions.normalizeAttrs "${username}.opts" vars.schema userOpts;
          homeModules = functions.recursive.importFilesToModules ../../modules/home (
            path:
            let
              rel = lib.removeSuffix ".nix" (
                lib.removePrefix (toString ../../modules/home + "/") (toString path)
              );
              parts = lib.take 2 (lib.splitString "/" rel);
            in
            lib.attrByPath (parts ++ [ "enable" ]) false userOptsNormalized
          );
        in
        {
          name = username;
          value = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = pkgSets.pkgs;
            modules = homeModules ++ [
              {
                home = {
                  inherit username stateVersion;
                  homeDirectory = "/home/${username}";
                };
              }
            ];
            extraSpecialArgs = {
              inherit
                vars
                inputs
                pkgSets
                functions
                ;
              opts = userOptsNormalized;
            };
          };
        }
      ) userNames
    )
  ) userDirs
)
