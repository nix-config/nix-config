{
  pkgs,
  ...
}:
{
  config = {
    programs.opencode = {
      enable = true;
      extraPackages = with pkgs; [
        gh
        jq
        nodejs
        python3
      ];
      enableMcpIntegration = true;
      settings = {
        plugins = [
          "billion-context@0.1.209"
          "oh-my-opencode-slim@3.0.6"
        ];
        compaction.auto = false;
      };
    };
  };
}
