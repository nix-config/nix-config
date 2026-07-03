vars: {
  # 用户配置
  user = {
    # 预定义选项集列表
    predefinedOptSetsList = with vars.optSets; [
      baseEnv
      fishShell
    ];
    # 自定义选项集
    customOptSets = {
      count = 1;
      stateVersion = "26.05";
      system = "x86_64-linux";
      nixConfigPath = "path/to/nix-config";
      i18n.locale = "en-us";
      hardware.graphics.type = "none";
    };
  };
}
