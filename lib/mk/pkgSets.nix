/*
  功能:
    从 inputs 中提取所有含 nixpkgs 的输入, 实例化为包 attrs
    并将 key 命名为 pkgs-* 形式
  输入参数:
    system: 目标平台字符串 (如 "x86_64-linux", "aarch64-darwin")
    mainInputs: flake inputs 的 attrset (如 { nixpkgs = ...; nixpkgs-unstable = ...; ... })
  返回值:
    包含多个对应平台的包的 attrs
  示例:
    functions.mk.pkgSets "x86_64-linux"
  =>
    {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    }
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  function =
    system: mainInputs:
    let
      nixpkgsInputs = lib.filterAttrs (n: _: lib.hasPrefix "nixpkgs" n) mainInputs;
    in
    (import ../mapAttrsPrime.nix inputs) (name: value: {
      name = "pkgs${lib.removePrefix "nixpkgs" name}";
      value = import value {
        inherit system;
        config.allowUnfree = true;
      };
    }) nixpkgsInputs;
in
function
