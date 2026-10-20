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
        mcp-nixos
        nodejs
        python3
      ];
      enableMcpIntegration = false;
      settings = { };
    };
    home.file = {
      ".config/opencode/opencode.jsonc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/opencode.jsonc";
        force = true;
      };
    };
  };
}
