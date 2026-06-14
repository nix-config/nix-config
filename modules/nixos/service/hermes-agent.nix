{
  lib,
  opts,
  config,
  inputs,
  pkgSets,
  ...
}:
let
  cfg = opts.service.hermes-agent or { };
  enableSopsNix = opts.service.sops-nix.enable or false;
  finallyEnable = cfg.enable or false && enableSopsNix;
in
{
  imports = [
    inputs.hermes-agent.nixosModules.default
  ];
  config = lib.mkIf finallyEnable {
    sops.secrets."hermes.env" = lib.mkIf enableSopsNix {
      sopsFile = ../../../secrets/hermes.env;
      format = "dotenv";
      owner = "hermes";
      mode = "0660";
    };
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
      settings = {
        model = {
          provider = "opencode-go";
          default = "deepseek-v4-pro";
        };
        auxiliary = {
          vision = {
            provider = "opencode-go";
            model = "qwen3.7-plus";
          };
          title_generation = {
            provider = "opencode-go";
            model = "deepseek-v4-flash";
          };
        };
        web.search_backend = "searxng";
        gateway.platforms = {
          # qqbot.enabled = true;
          feishu.enabled = true;
        };
        platform_toolsets = {
          feishu = [
            "web"
            "file"
            "todo"
            "memory"
            "skills"
            "vision"
            "clarify"
            "terminal"
            "delegation"
            "session_search"
          ];
        };
      };
      environmentFiles = [ config.sops.secrets."hermes.env".path ];
    };
    # 注入 lark-oapi 及其依赖到 hermes-agent 的 Python 环境 (Feishu 网关依赖)
    systemd.services.hermes-agent.environment.PYTHONPATH =
      let
        inherit (pkgSets.pkgs-knightfemale.python312Packages) lark-oapi;
        inherit (pkgSets.pkgs.python312Packages) requests-toolbelt pycryptodome;
      in
      lib.concatStringsSep ":" [
        "${lark-oapi}/lib/python3.12/site-packages"
        "${pycryptodome}/lib/python3.12/site-packages"
        "${requests-toolbelt}/lib/python3.12/site-packages"
      ];
  };
}
