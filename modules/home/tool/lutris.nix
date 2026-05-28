{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.tool.lutris or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
  # 禁用 openldap 在 i686 上的测试
  pkgs-patched = pkgs.extend (
    final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      });
    }
  );
in
{
  config = lib.mkIf finallyEnable {
    programs.lutris = {
      enable = true;
      package = pkgs-patched.lutris;
      # 为 lutris 配合 umu-launcher 使用而添加的 proton 软件包列表
      protonPackages = with pkgs; [
        dwproton-bin
      ];
    };
    home.packages = with pkgs; [
      umu-launcher
    ];
  };
}
