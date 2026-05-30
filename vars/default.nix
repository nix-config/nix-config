inputs:
let
  functions = import ../functions inputs;
in
functions.importFilesForAttrs ./.
