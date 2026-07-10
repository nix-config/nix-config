{
  lib,
  opts,
  config,
  ...
}:
let
  cfg = opts.display.dms or { };
  desktopTypeIsWsl = (opts.display.desktopType or "none") == "wsl";
  desktopTypeIsNone = (opts.display.desktopType or "none") == "none";
  finallyEnable = (cfg.enable or false) && (!desktopTypeIsWsl) && (!desktopTypeIsNone);
  configPath = "${opts.nixConfigPath}/modules/home/display/dms/config";
in
{
  config = lib.mkIf finallyEnable {
    home.file = {
      ".config/DankMaterialShell" = {
        source = config.lib.file.mkOutOfStoreSymlink configPath;
        force = true;
      };
    };
  };
}
