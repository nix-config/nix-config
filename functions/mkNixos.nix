/*
  功能:
    生成一个或多个 nixosConfigurations(根据 opts.host.count 决定实例数量)
    并支持用户批量生成(根据 opts.users.<name>.count 展开用户实例)
  输入参数:
    opts: 原始选项属性集
    baseName: 基础主机名(用作实例名称前缀)
  返回值:
    { "基础名称" = ...; } 或 { "基础名称-1" = ...; "基础名称-2" = ...; ... }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  # 导入辅助函数
  buildPkgSets = import ./buildPkgSets.nix inputs;
  deepMergeAttrs = import ./deepMergeAttrs.nix inputs;
  mergeAttrsList = import ./mergeAttrsList.nix inputs;
  generateCountNames = import ./generateCountNames.nix inputs;
  mkNixos =
    opts: baseName: vars:
    let
      # 从 opts 获取信息
      hostCustomOptSets = opts.host.customOptSets or [ ];
      count = hostCustomOptSets.count or 1;
      system = hostCustomOptSets.system or "x86_64-linux";
      pkgSets = buildPkgSets system;
      stateVersion = hostCustomOptSets.stateVersion or "25.11";
      hostPredefinedOptSetsList = opts.host.predefinedOptSetsList or [ ];
      nixosOpts = deepMergeAttrs (mergeAttrsList hostPredefinedOptSetsList) hostCustomOptSets;
      # 定义用户批量展开函数
      expandUsers =
        users:
        lib.concatMapAttrs (
          baseName: attrs:
          let
            # 强制 root 用户 count 为 1
            count = if baseName == "root" then 1 else (attrs.customOptSets.count or 1);
            names = generateCountNames baseName count;
          in
          lib.genAttrs names (_: attrs)
        ) users;
      # 根据 count 生成主机名称列表
      hostNames = generateCountNames baseName count;
      # 展开后的用户属性集
      expandedUsers = expandUsers (opts.users or { });
      # 提取所有用户的 base 配置(即 users.<name>.base)
      usersBase = lib.mapAttrs (_: user: user.base or { }) expandedUsers;
      # 筛选出非 root 用户(用于 Home Manager 配置)
      nonRootUsers = lib.filterAttrs (name: _: name != "root") expandedUsers;
      # 定义生成单个 nixosConfigurations 的函数
      mkSingleNixos =
        hostName:
        let
          # 深度合并特定的 hostName 到原有 nixosOpts 中
          nixosOpts' = deepMergeAttrs nixosOpts { hardware.networking.hostName = hostName; };
        in
        {
          ${hostName} = lib.nixosSystem {
            inherit system;
            pkgs = pkgSets.pkgs;
            # 传给子模块的参数
            specialArgs = {
              inherit vars inputs pkgSets;
              opts = nixosOpts';
            };
            modules = [
              # nixos 模块
              ../modules/nixos
              # 自动生成的硬件配置
              (../outputs/nixos + "/${baseName}/hardware-configuration.nix")
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
                      homeOpts = deepMergeAttrs (mergeAttrsList homePredefined) homeCustom;
                      # 再与全局主机选项合并, 作为最终传递给 home 模块的 opts
                      homeOpts' = deepMergeAttrs nixosOpts' homeOpts;
                    in
                    {
                      imports = [ ../modules/home ];
                      home = {
                        inherit username;
                        homeDirectory = "/home/${username}";
                        stateVersion = "26.05";
                      };
                      # 通过 _module.args 将用户专属的 opts 传入 home 模块
                      _module.args = {
                        opts = homeOpts';
                      };
                    }
                  ) nonRootUsers;
                  # 全局 extraSpecialArgs 不传递 opts, 避免覆盖用户专属配置
                  extraSpecialArgs = { inherit vars inputs pkgSets; };
                };
              }
            ];
          };
        };
    in
    # 将所有实例配置合并为一个属性集
    lib.foldl' (acc: name: acc // (mkSingleNixos name)) { } hostNames;
in
mkNixos
