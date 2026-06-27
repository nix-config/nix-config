{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
  cfg = opts.editor.vscode.extensions.javascript or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
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
