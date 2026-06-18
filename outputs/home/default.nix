{
  lib,
  vars,
  inputs,
  optSets,
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
      opts = import (./. + "/${baseName}/opts.nix") {
        inherit vars optSets;
        hostName = baseName;
      };
      # 从 opts 获取信息
      userCustomOptSets = opts.user.customOptSets or { };
      count = userCustomOptSets.count or 1;
      system = userCustomOptSets.system or "x86_64-linux";
      pkgSets = functions.mk.pkgSets system;
      stateVersion = userCustomOptSets.stateVersion or "26.05";
      userPredefinedOptSetsList = opts.user.predefinedOptSetsList or [ ];
      homeOpts = functions.recursiveMergeAttrs (functions.recursiveMergeAttrsList userPredefinedOptSetsList) userCustomOptSets;
      # 根据 count 生成用户名称列表
      userNames = functions.generateCountNames baseName count;
    in
    builtins.listToAttrs (
      map (username: {
        name = username;
        value = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgSets.pkgs;
          modules = [
            # home 模块
            ../../modules/home
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
            opts = homeOpts;
          };
        };
      }) userNames
    )
  ) userDirs
)
