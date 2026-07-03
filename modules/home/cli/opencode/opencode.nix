{
  lib,
  pkgs,
  opts,
  config,
  ...
}:
let
  cfg = opts.cli.opencode or { };
  finallyEnable = cfg.enable or false;
  configPath = "${opts.nixConfigPath}/modules/home/cli/opencode/config";
in
{
  config = lib.mkIf finallyEnable {
    programs.opencode = {
      enable = true;
      extraPackages = with pkgs; [
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
