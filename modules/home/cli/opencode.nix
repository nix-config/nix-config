{
  pkgs,
  ...
}:
{
  config = {
    programs.opencode = {
      enable = true;
      # TODO: NixOS/nixpkgs#563241
      package = pkgs.opencode.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace packages/opencode/script/build.ts \
            --replace-fail 'splitting: true,' 'splitting: false,'
        '';
      });
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
          "npm:opencode-acp@stable"
        ];
        compaction.auto = false;
      };
    };
  };
}
