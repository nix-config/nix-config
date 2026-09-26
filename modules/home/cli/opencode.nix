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
          "npm:oh-my-opencode-slim@2.2.25"
          "npm:opencode-acp@1.18.2"
        ];
        compaction.auto = false;
      };
    };
  };
}
