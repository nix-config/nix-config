{
  lib,
  pkgs,
  opts,
  config,
  ...
}:
let
  enableModule = opts.cli.opencode.enable;
  configPath = "${opts.nixConfigPath}/modules/home/cli/opencode/config";
in
{
  config = lib.mkIf enableModule {
    programs.opencode = {
      enable = true;
      extraPackages = with pkgs; [
        gh
        jq
        bun
      ];
    };
    home.file = {
      ".config/opencode" = {
        source = config.lib.file.mkOutOfStoreSymlink configPath;
        force = true;
      };
    };
  };
}
