{
  lib,
  opts,
  config,
  ...
}:
let
  enableModule =
    (lib.elem "dms-shell" opts.display.widget.enabledWidgets) && opts.display.desktop.enable;
  configPath = "${opts.nixConfigPath}/modules/home/display/widget/dms-shell/config";
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
