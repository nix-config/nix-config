/*
  功能:
    根据目标平台解析并实例化 nixpkgs 包集合
  输入参数:
    system: 目标平台字符串(如 "x86_64-linux", "aarch64-darwin")
  返回值:
    包含多个对应平台的包集合属性集
*/
inputs:
let
  buildPkgSets =
    system: with inputs; {
      # 最新版 nixpkgs 包集合
      pkgs = import nixpkgs {
        inherit system;
        # 允许使用非自由软件
        config.allowUnfree = true;
      };
      # 不稳定版 nixos 包集合
      pkgs-nixos-unstable = import nixos-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      # knightfemale fork 版 nixpkgs 包集合
      pkgs-knightfemale = import nixpkgs-knightfemale {
        inherit system;
        config.allowUnfree = true;
      };
    };
in
buildPkgSets
