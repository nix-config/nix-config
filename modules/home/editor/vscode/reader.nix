{
  lib,
  pkgs,
  opts,
  ...
}:
let
  cfg = opts.editor.vscode.extensions.reader or { };
  finallyEnable = cfg.enable or false || opts.editor.vscode.extensions.all.enable or false;
in
{
  config = lib.mkIf finallyEnable {
    programs.vscode.profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
        # PDF 阅读器
        tomoki1207.pdf
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # EPUB 电子书阅读器
          name = "epub-reader";
          publisher = "cweijan";
          version = "1.0.0";
          sha256 = "sha256-wundHVZ0GNcddIh1Af+fBobdKsswk+MMoFVnI7hjgTQ=";
        }
      ];
  };
}
