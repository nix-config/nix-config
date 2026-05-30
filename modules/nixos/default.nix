{
  inputs,
  ...
}:
let
  functions = import ../../functions inputs;
in
{
  imports = functions.importFilesForModules ./.;
}
