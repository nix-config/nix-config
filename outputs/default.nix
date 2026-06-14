inputs:
let
  # 从 nixpkgs 输入中获取 lib 工具库
  inherit (inputs.nixpkgs) lib;
  # 导入公共变量
  vars = import ../vars upstreamFunctions;
  # 导入选项集
  optSets = import ./optSets upstreamFunctions;
  # 合并上游和本地公共函数
  functions = lib.recursiveUpdate upstreamFunctions localFunctions;
  # 导入本地公共函数
  localFunctions = import ../functions {
    inherit inputs;
    functions = upstreamFunctions;
  };
  # 导入上游公共函数
  upstreamFunctions = inputs.nur-knightfemale.functions;
in
{
  # 输出结构: { nixosConfigurations = { "主机名" = ... }; }
  nixosConfigurations = import ./nixos {
    inherit
      lib
      vars
      inputs
      optSets
      functions
      ;
  };
  # 输出结构: { homeConfigurations = { "用户名" = ... }; }
  homeConfigurations = import ./home {
    inherit
      lib
      vars
      inputs
      optSets
      functions
      ;
  };
}
