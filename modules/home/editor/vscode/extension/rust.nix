{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions;
  enableModule = cfg.rust.enable || cfg.all.enable;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # Rust 语法支持
      rust-lang.rust-analyzer
      # TOML 语法支持
      tamasfe.even-better-toml
    ];
  };
}
