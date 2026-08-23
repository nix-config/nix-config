{
  pkgs,
  ...
}:
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
      tui = {
        plugin = [
          "npm:opencode-subagent-magazine@latest"
        ];
      };
    };
  };
}
