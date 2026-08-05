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
      # Tailwind CSS 支持
      bradlc.vscode-tailwindcss
      # ESLint 支持
      dbaeumer.vscode-eslint
      # Ripple 支持
      ripple-ts.ripple-ts-vscode-plugin
      # Svelte 支持
      svelte.svelte-vscode
      # Tauri 支持
      tauri-apps.tauri-vscode
    ];
  };
}
