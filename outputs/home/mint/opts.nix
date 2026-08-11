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
      nixConfigPath = "/home/mint/workspace/nix-config";
      cli.zellij.enable = true;
    };
  };
}
