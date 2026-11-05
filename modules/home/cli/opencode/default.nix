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
          "billion-context@0.1.212"
          "oh-my-opencode-slim@3.0.7"
        ];
        compaction.auto = false;
      };
    };
  };
}
