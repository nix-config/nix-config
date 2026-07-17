{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  inherit (opts.editor.vscode) enabledExtensions;
  enableModule = (lib.elem "javascript" enabledExtensions) || (lib.elem "all" enabledExtensions);
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # ESLint 集成
      dbaeumer.vscode-eslint
      # Tailwind CSS 语法支持
      bradlc.vscode-tailwindcss
      # Svelte 框架支持
      svelte.svelte-vscode
      # Ripple 框架辅支持
      ripple-ts.ripple-ts-vscode-plugin
    ];
  };
}
