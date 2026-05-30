inputs:
let
  importFilesForAttrs = import ./importFilesForAttrs.nix inputs;
in
importFilesForAttrs ./.
