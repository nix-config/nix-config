{
  lib,
  opts,
  config,
  ...
}:
let
  enableModule = opts.service.sops-nix.enable;
  firewall = opts.hardware.networking.firewall;
in
{
  config = lib.mkIf enableModule {
    sops.secrets."searxng.env" = {
      sopsFile = ../../../secrets/searxng.env;
      format = "dotenv";
      owner = "root";
      group = "root";
      mode = "0400";
    };
    containers.searxng = {
      autoStart = true;
      privateNetwork = false;
      bindMounts = {
        "/run/secrets/searxng.env" = {
          hostPath = config.sops.secrets."searxng.env".path;
          isReadOnly = true;
        };
      };
      config = { ... }: {
        services.searx = {
          enable = true;
          # 使用 Redis 限流/缓存/会话存储
          redisCreateLocally = true;
          # 使用 uWSGI 运行生产模式
          configureUwsgi = true;
          uwsgiConfig = {
            socket = "/run/searx/searx.sock";
            chmod-socket = "660";
            # 直连 HTTP 端口 (不依赖 Nginx)
            http = ":8888";
          };
          environmentFile = "/run/secrets/searxng.env";
          settings = {
            # 支持的请求格式
            search.formats = [
              "html"
              "json"
            ];
            server = {
              # 允许局域网访问
              bind_address = "0.0.0.0";
              # 是否限流
              limiter = false;
              # 引用环境变量
              secret_key = "$SEARXNG_SECRET";
            };
          };
        };
        networking.firewall = firewall;
        system.stateVersion = opts.stateVersion;
      };
    };
  };
}
