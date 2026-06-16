{
  inputs,
  functions,
  ...
}:
{
  mkHome = import ./mkHome.nix { inherit inputs functions; };
  mkNixos = import ./mkNixos.nix { inherit inputs functions; };
  buildPkgSets = import ./buildPkgSets.nix inputs;
}
