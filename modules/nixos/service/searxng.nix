{
  lib,
  opts,
  config,
  inputs,
  ...
}:
let
  enableModule = opts.service.sops-nix.enable;
  inherit (opts.service.searxng) port;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  config = lib.mkIf enableModule {
    sops.secrets."searxng.env" = {
      sopsFile = ../../../secrets/searxng.env;
      format = "dotenv";
      owner = "root";
      group = "root";
      mode = "0400";
    };
    services.searx = {
      enable = true;
      # 使用 uWSGI 运行生产模式
      configureUwsgi = true;
      uwsgiConfig = {
        socket = "/run/searx/searx.sock";
        chmod-socket = "660";
        # 直连 HTTP 端口 (不依赖 Nginx)
        http = ":${toString port}";
      };
      environmentFile = config.sops.secrets."searxng.env".path;
      settings = {
        # 支持的请求格式
        search.formats = [
          "html"
          "json"
        ];
        server = {
          # 允许局域网访问
          bind_address = "0.0.0.0";
          inherit port;
          # 是否限流
          limiter = false;
          # 引用环境变量
          secret_key = "$SEARXNG_SECRET";
        };
      };
      openFirewall = true;
    };
  };
}
