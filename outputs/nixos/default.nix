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
  # 筛选出所有符合要求的主机目录
  hostDirs = builtins.attrNames (
    lib.filterAttrs (
      name: type:
      # 是目录
      type == "directory"
      # 存在 opts.nix
      && builtins.pathExists (./. + "/${name}/opts.nix")
      # 存在 hardware-configuration.nix
      && builtins.pathExists (./. + "/${name}/hardware-configuration.nix")
    ) content
  );
in
lib.mergeAttrsList (
  map (
    baseName:
    let
      opts = import (./. + "/${baseName}/opts.nix") vars;
      # 从 opts 获取信息
      hostCustomOptSets = opts.host.customOptSets or [ ];
      count = hostCustomOptSets.count or 1;
      system = hostCustomOptSets.system or "x86_64-linux";
      pkgSets = functions.mk.pkgSets system inputs;
      stateVersion = hostCustomOptSets.stateVersion or "26.05";
      hostPredefinedOptSetsList = opts.host.predefinedOptSetsList or [ ];
      nixosOpts = functions.recursive.mergeAttrs (functions.recursive.mergeAttrsList hostPredefinedOptSetsList) hostCustomOptSets;
      # 根据 count 生成主机名称列表
      hostNames = functions.mk.numberedStrings baseName count;
      # 展开后的用户属性集
      expandedUsers = lib.concatMapAttrs (
        name: attrs:
        let
          # 强制 root 用户 count 为 1
          count = if name == "root" then 1 else (attrs.customOptSets.count or 1);
        in
        lib.genAttrs (functions.mk.numberedStrings name count) (_: attrs)
      ) (opts.users or { });
      # 提取所有用户的 base 配置 (即 users.<name>.base)
      usersBase = lib.mapAttrs (_: user: user.base or { }) expandedUsers;
      # 筛选出非 root 用户 (用于 Home Manager 配置)
      nonRootUsers = lib.filterAttrs (name: _: name != "root") expandedUsers;
    in
    builtins.listToAttrs (
      map (
        hostName:
        let
          # 深度合并特定的 hostName 到原有 nixosOpts 中
          nixosOpts' = functions.recursive.mergeAttrs nixosOpts { hardware.networking.hostName = hostName; };
        in
        {
          name = hostName;
          value = lib.nixosSystem {
            inherit system;
            pkgs = pkgSets.pkgs;
            # 传给子模块的参数
            specialArgs = {
              inherit
                vars
                inputs
                pkgSets
                functions
                ;
              opts = functions.checkAttrs "${hostName}.opts." vars.schema nixosOpts';
            };
            modules = [
              # nixos 模块
              ../../modules/nixos
              # 自动生成的硬件配置
              (./. + "/${baseName}/hardware-configuration.nix")
              # Home Manager 模块
              inputs.home-manager.nixosModules.home-manager
              {
                # 初始状态版本
                system.stateVersion = stateVersion;
                users = {
                  # 设置 false 开启完全声明式管理
                  mutableUsers = false;
                  # 声明的用户
                  users = usersBase;
                };
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  # 为每个非 root 用户生成独立的 Home Manager 模块
                  users = lib.mapAttrs (
                    username: attrs:
                    let
                      # 合并用户级别的预定义选项列表和自定义选项
                      homePredefined = attrs.predefinedOptSetsList or [ ];
                      homeCustom = attrs.customOptSets or { };
                      homeOpts = functions.recursive.mergeAttrs (functions.recursive.mergeAttrsList homePredefined) homeCustom;
                      # 再与全局主机选项合并, 作为最终传递给 home 模块的 opts
                      homeOpts' = functions.recursive.mergeAttrs nixosOpts' homeOpts;
                    in
                    {
                      imports = [ ../../modules/home ];
                      home = {
                        inherit username stateVersion;
                        homeDirectory = lib.mkDefault "/home/${username}";
                      };
                      # 通过 _module.args 将用户专属的 opts 传入 home 模块
                      _module.args = {
                        opts = functions.checkAttrs "${hostName}.${username}.opts." vars.schema homeOpts';
                      };
                    }
                  ) nonRootUsers;
                  # 全局 extraSpecialArgs 不传递 opts, 避免覆盖用户专属配置
                  extraSpecialArgs = {
                    inherit
                      vars
                      inputs
                      pkgSets
                      functions
                      ;
                  };
                };
              }
            ];
          };
        }
      ) hostNames
    )
  ) hostDirs
)
