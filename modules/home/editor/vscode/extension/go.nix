{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions;
  enableModule = cfg.go.enable || cfg.all.enable;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # Go 语法支持
      golang.go
    ];
  };
}
