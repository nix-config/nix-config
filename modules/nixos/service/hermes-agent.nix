{
  lib,
  pkgs,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.sops-nix.enable;
  hermes-panel = pkgs.fetchFromGitHub {
    owner = "knightfemale";
    repo = "hermes-panel";
    rev = "fcb5f4f3abba333d206fe94e3e533bfe1c83d15c";
    hash = "sha256-G+M0CFLEmb2AYjXkgi0vwGSXOW6T6iE5AvyUrx27fd8=";
  };
in
{
  imports = [
    inputs.hermes-agent.nixosModules.default
    inputs.sops-nix.nixosModules.sops
  ];
  config = lib.mkIf enableModule {
    sops.secrets = {
      "hermes-agent/.env" = {
        sopsFile = ../../../secrets/hermes-agent/.env;
        format = "dotenv";
        owner = "hermes";
        mode = "0660";
      };
      "hermes-agent/hermes-panel-script.py" = {
        sopsFile = ../../../secrets/hermes-agent/hermes-panel-script.enc;
        format = "binary";
        owner = "hermes";
        mode = "0400";
      };
    };
    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;
      extraDependencyGroups = [
        "feishu"
      ];
      extraPlugins = [
        hermes-panel
      ];
      settings = {
        model = {
          provider = "opencode-go";
          default = "deepseek-v4.1-flash";
        };
        web.search_backend = "searxng";
        plugins = {
          enabled = [
            "hermes-panel"
          ];
          entries.hermes-panel.settings.script =
            config.sops.secrets."hermes-agent/hermes-panel-script.py".path;
        };
        gateway.platforms = {
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
      environmentFiles = [
        config.sops.secrets."hermes-agent/.env".path
      ];
    };
  };
}
