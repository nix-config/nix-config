{
  lib,
  opts,
  config,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
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
