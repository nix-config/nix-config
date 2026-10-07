{
  lib,
  pkgs,
  opts,
  ...
}:
let
  polkitIsEnabled = opts.service.polkit.enable;
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
        plugin = lib.flatten [
          [
            "npm:oh-my-opencode-slim@3.0.2"
            "npm:opencode-acp@1.18.3"
          ]
          (lib.optionals polkitIsEnabled [
            "npm:opencode-polkit@0.1.5"
          ])
        ];
        compaction.auto = false;
      };
    };
  };
}
