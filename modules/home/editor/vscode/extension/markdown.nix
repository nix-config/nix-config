{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  inherit (opts.editor.vscode) enabledExtensions;
  enableModule = (lib.elem "markdown" enabledExtensions) || (lib.elem "all" enabledExtensions);
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # 语法检查
      davidanson.vscode-markdownlint
    ];
  };
}
