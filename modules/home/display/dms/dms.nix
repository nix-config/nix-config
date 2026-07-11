{
  lib,
  opts,
  config,
  ...
}:
let
  desktopTypeIsWsl = opts.display.desktopType == "wsl";
  desktopTypeIsNone = opts.display.desktopType == "none";
  enableModule = opts.display.dms.enable && (!desktopTypeIsWsl) && (!desktopTypeIsNone);
  configPath = "${opts.nixConfigPath}/modules/home/display/dms/config";
in
{
  config = lib.mkIf enableModule {
    home.file = {
      ".config/DankMaterialShell" = {
        source = config.lib.file.mkOutOfStoreSymlink configPath;
        force = true;
      };
    };
  };
}
