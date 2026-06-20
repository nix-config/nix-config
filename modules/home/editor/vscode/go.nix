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
  cfg = opts.editor.vscode.extensions.go or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # Go 语法支持
      golang.go
    ];
  };
}
