{
  lib,
  ...
}:
{
  config = {
    # pnpm_9 (v9.15.9) 被 nixpkgs 标记为不安全
    # 此覆层清空其 knownVulnerabilities 以放行构建
    nixpkgs.overlays = [
      (final: prev: {
        pnpm_9 = prev.pnpm_9.overrideAttrs (old: {
          meta = lib.mergeAttrs [
            (old.meta or { })
            { knownVulnerabilities = [ ]; }
          ];
        });
      })
    ];
  };
}
