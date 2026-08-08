{
  lib,
  pkgs,
  osConfig,
  opts,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
  steamCfg = osConfig.programs.steam;
in
{
  config = lib.mkIf enableModule {
    programs.lutris = {
      enable = true;
      # 与 programs.steam 共享同一实例, 避免双 Steam 冲突
      steamPackage = steamCfg.package;
      # 与 programs.steam 共享 Proton 列表
      protonPackages = steamCfg.protonPackages;
      extraPackages = with pkgs; [
        mangohud
        umu-launcher
      ];
    };
  };
}
