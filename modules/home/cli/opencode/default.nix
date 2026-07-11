{
  pkgs,
  opts,
  config,
  ...
}:
let
  configPath = "${opts.nixConfigPath}/modules/home/cli/opencode/config";
in
{
  config = {
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
