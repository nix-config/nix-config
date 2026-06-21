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
      settings = {
        plugin = [
          "oh-my-openagent"
        ]; 
      };
    };
    home.file = {
      ".config/opencode/oh-my-openagent.jsonc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/oh-my-openagent.jsonc";
        force = true;
      };
    };
  };
}
