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
        bun
        gh
        jq
        python3
      ];
      enableMcpIntegration = true;
      settings = {
        lsp = true;
        plugin = [
          "npm:oh-my-opencode-slim@latest"
        ];
      };
    };
    home.file = {
      ".config/opencode/oh-my-opencode-slim.jsonc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${configPath}/oh-my-opencode-slim.jsonc";
        force = true;
      };
    };
  };
}
