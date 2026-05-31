{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions.rust or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
      # Rust 语法支持
      rust-lang.rust-analyzer
      # TOML 语法支持
      tamasfe.even-better-toml
    ];
  };
}
