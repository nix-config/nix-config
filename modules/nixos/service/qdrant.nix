{
  lib,
  opts,
  ...
}:
let
  firewall = opts.hardware.networking.firewall;
  inherit (opts.service.qdrant) instances;
in
{
  config = lib.mkIf opts.service.qdrant.enable {
    containers = builtins.listToAttrs (
      map (inst: {
        name = inst.name;
        value = {
          autoStart = true;
          privateNetwork = false;
          config = { ... }: {
            services.qdrant = {
              enable = true;
              settings = {
                service.host = "0.0.0.0";
                service.port = inst.port;
                service.grpc_port = inst.port + 1;
              };
            };
            networking.firewall = firewall;
            system.stateVersion = opts.stateVersion;
          };
        };
      }) instances
    );
  };
}
