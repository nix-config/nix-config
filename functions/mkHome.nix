/*
  功能:
    生成一个或多个 homeConfigurations(根据 opts.user.count 决定实例数量)
  输入参数:
    opts: 原始选项属性集
    baseName: 基础用户名(用作实例名称前缀)
  返回值:
    { "基础名称" = ...; } 或 { "基础名称" = ...; "基础名称-1" = ...; "基础名称-2" = ...; }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  # 导入辅助函数
  buildPkgSets = import ./buildPkgSets.nix inputs;
  deepMergeAttrs = import ./deepMergeAttrs.nix inputs;
  mergeAttrsList = import ./mergeAttrsList.nix inputs;
  generateCountNames = import ./generateCountNames.nix inputs;
  mkHome =
    opts: baseName: vars:
    let
      # 从 opts 获取信息
      userCustomOptSets = opts.user.customOptSets or { };
      count = userCustomOptSets.count or 1;
      system = userCustomOptSets.system or "x86_64-linux";
      pkgSets = buildPkgSets system;
      userPredefinedOptSetsList = opts.user.predefinedOptSetsList or [ ];
      homeOpts = deepMergeAttrs (mergeAttrsList userPredefinedOptSetsList) userCustomOptSets;
      # 根据 count 生成用户名称列表
      userNames = generateCountNames baseName count;
      # 定义生成单个 homeConfigurations 的函数
      mkSingleHome = username: {
        ${username} = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgSets.pkgs;
          modules = [
            ../modules/home
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "26.11";
              };
            }
          ];
          extraSpecialArgs = {
            inherit vars inputs pkgSets;
            opts = homeOpts;
          };
        };
      };
    in
    lib.foldl' (acc: name: acc // (mkSingleHome name)) { } userNames;
in
mkHome
