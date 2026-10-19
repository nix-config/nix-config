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
        nodejs
        python3
      ];
      enableMcpIntegration = true;
      settings = {
        lsp = true;
        plugin = [
          "npm:oh-my-opencode-slim@3.0.5"
          "npm:billion-context@0.1.201"
        ];
        compaction.auto = false;
      };
    };
  };
}
