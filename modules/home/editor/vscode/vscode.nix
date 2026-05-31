{
  lib,
  opts,
  config,
  ...
}:
let
  cfg = opts.editor.vscode or { };
  finallyEnable = cfg.enable or false && ((opts.desktop.type or "") != "");
  configPath = "${opts.nixConfigPath}/modules/config";
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.enable = true;
    home.file = {
      ".vscode/argv.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/argv.json";
        force = true;
      };
      ".config/Code/User/settings.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/vscode/settings.json";
        force = true;
      };
    };
  };
}
