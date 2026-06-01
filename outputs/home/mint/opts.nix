{
  vars,
  optSets,
  ...
}:
let
  user = {
    predefinedOptSetsList = with optSets; [
      baseEnv
      fishShell
    ];
    customOptSets = {
      count = 1;
      system = vars.systemTypes.x86_64-linux;
      stateVersion = "26.05";
      nixConfigPath = "/home/mint/workspace/mochen/nix-config";
      cli = {
        nvitop.enable = true;
      };
      i18n = {
        locale = vars.localeTypes.zh-cn;
      };
      hardware = {
        graphics.type = vars.gpuTypes.nvidia;
      };
    };
  };
in
{
  inherit user;
}
