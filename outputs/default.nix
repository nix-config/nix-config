inputs:
let
  # 从 nixpkgs 输入中获取 lib 工具库
  inherit (inputs.nixpkgs) lib;
  # 导入公共变量
  vars = import ../vars functions;
  # 导入公共函数
  functions = inputs.nur-knightfemale.functions;
in
{
  # 输出结构: { nixosConfigurations = { "主机名" = ... }; }
  nixosConfigurations = import ./nixos {
    inherit
      lib
      vars
      inputs
      functions
      ;
  };
  # 输出结构: { homeConfigurations = { "用户名" = ... }; }
  homeConfigurations = import ./home {
    inherit
      lib
      vars
      inputs
      functions
      ;
  };
}
