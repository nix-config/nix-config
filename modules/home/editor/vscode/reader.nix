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
  cfg = opts.editor.vscode.extensions.reader or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions = with vscode-marketplace; [
      # PDF 阅读器
      tomoki1207.pdf
      # EPUB 电子书阅读器
      cweijan.epub-reader
    ];
  };
}
