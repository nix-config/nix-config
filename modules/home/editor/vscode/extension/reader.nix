{
  lib,
  pkgs,
  inputs,
  opts,
  ...
}:
let
  inherit (opts.editor.vscode) enabledExtensions;
  enableModule = (lib.elem "reader" enabledExtensions) || (lib.elem "all" enabledExtensions);
  vscode-marketplace =
    (pkgs.extend inputs.nix-vscode-extensions.overlays.default).vscode-marketplace-release;
in
{
  config = lib.mkIf enableModule {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # PDF 阅读器
      tomoki1207.pdf
      # EPUB 电子书阅读器
      cweijan.epub-reader
    ];
  };
}
