{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions.javascript or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        # ESLint 集成
        dbaeumer.vscode-eslint
        # Tailwind CSS 语法支持
        bradlc.vscode-tailwindcss
        # Svelte 框架支持
        svelte.svelte-vscode
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # Ripple 框架辅支持
          name = "ripple-ts-vscode-plugin";
          publisher = "Ripple-TS";
          version = "2.0.22";
          sha256 = "sha256-kv1WDGng8qWTRIoBKw/rTxUUf5fN88DEqYYSkYq5xyg=";
        }
      ];
  };
}
