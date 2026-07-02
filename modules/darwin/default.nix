{
  functions,
  ...
}:
{
  imports = functions.recursive.importFilesToModules ./.;
}
