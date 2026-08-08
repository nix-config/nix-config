{
  lib,
  pkgs,
  opts,
  config,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
in
{
  options.programs.steam.protonPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
  };
  config = lib.mkIf enableModule {
    programs.steam = {
      enable = true;
      protonPackages = with pkgs; [
        dwproton-bin
      ];
      extraCompatPackages = config.programs.steam.protonPackages;
    };
  };
}
