{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  extensions = opts.editor.vscode.extensions;
  enableModule = lib.elem "nix" extensions || lib.elem "all" extensions;
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # Nix 语法支持
      jnoortheen.nix-ide
      # direnv 支持
      mkhl.direnv
    ];
  };
}
