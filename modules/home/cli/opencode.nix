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
          "npm:oh-my-opencode-slim@3.0.2"
          "npm:opencode-acp@1.18.3"
          "npm:opencode-polkit@0.1.5"
        ];
        compaction.auto = false;
      };
    };
  };
}
