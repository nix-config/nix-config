{
  lib,
  opts,
  config,
  ...
}:
let
  enableModule = opts.display.desktop.enable;
  configPath = "${opts.nixConfigPath}/modules/home/editor/vscode/config";
in
{
  config = lib.mkIf enableModule {
    programs.vscode.enable = true;
    home.file = {
      ".vscode/argv.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/argv.json";
        force = true;
      };
      ".config/Code/User/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/settings.json";
        force = true;
      };
    };
  };
}
