/*
  功能:
     根据指定版本和源码构建自定义 Linux 内核, 并生成完整的内核包集合
  输入参数 (属性集):
    pkgs: nixpkgs 包集合
    version: 内核版本号
    modDirVersion: 内核模块目录版本号
    url: 内核源码下载地址
    sha256: 内核源码包的 SHA256 哈希值
  返回值:
    由 recurseIntoAttrs 包裹的完整内核包集合 (通过 pkgs.linuxPackagesFor 生成)
*/
inputs:
let
  inherit (inputs.nixpkgs) lib;
  mkKernelPackage =
    {
      pkgs,
      version,
      modDirVersion,
      url,
      sha256,
    }:
    let
      # 定义一个函数, 用于构建自定义的内核包
      linux_pkg =
        { fetchurl, buildLinux, ... }@args:
        #  调用 buildLinux 函数, 传入参数并覆盖部分属性
        buildLinux (
          args
          // rec {
            inherit version modDirVersion;
            src = fetchurl { inherit url sha256; };
            # 额外的内核补丁列表
            kernelPatches = [ ];
            #  添加内核包的元数据, 设置分支名便于识别
            extraMeta.branch = version;
            # 允许通过 argsOverride 进一步覆盖参数
          }
          // (args.argsOverride or { })
        );
      #  使用 pkgs.callPackage 调用上面定义的函数, 自动解析并传入所需的依赖
      linux = pkgs.callPackage linux_pkg { };
    in
    # 根据自定义内核生成完整的内核包集合
    # 然后使用 recurseIntoAttrs 让该属性集在 nix-env 等命令中被正确展开
    lib.recurseIntoAttrs (pkgs.linuxPackagesFor linux);
in
mkKernelPackage
