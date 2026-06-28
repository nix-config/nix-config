vars: {
  user = {
    predefinedOptSetsList = with vars.optSets; [
      baseEnv
      fishShell
    ];
    customOptSets = {
      count = 1;
      system = "x86_64-linux";
      stateVersion = "26.05";
      nixConfigPath = "/home/mint/workspace/mochen/nix-config";
      cli = {
        nvitop.enable = true;
      };
      i18n = {
        locale = "zh-cn";
      };
      hardware = {
        graphics.type = "nvidia";
      };
    };
  };
}
