{
  lib,
  pkgs,
  opts,
  config,
  ...
}:
let
  cfg = opts.service.llama-cpp or { };
  gpuType = (opts.hardware.graphics.type or "none");
  finallyEnable = (cfg.enable or false) && gpuType == "nvidia";
  isWsl = (opts.hardware.boot-loader.type or "none") == "wsl";
  extraSettings = cfg.extraSettings or { };
in
{
  config = lib.mkIf finallyEnable (
    lib.mkMerge [
      {
        services.llama-cpp = {
          enable = true;
          package = pkgs.llama-cpp.override { cudaSupport = true; };
          settings = lib.mkMerge [
            {
              host = "0.0.0.0";
              port = 8080;
              # 用于认证的 API 密钥 (逗号分隔列表)
              api-key = "1";
              # 要加载的模型路径
              # model = "/path/to/model";
              # 多模态投影仪文件路径
              # mmproj = "/path/to/mmproj";
              # 将前 N 层的 MoE 权重保留在 CPU 上
              n-cpu-moe = 0;
              # 大幅降低长上下文推理时的显存占用和首字延迟
              flash-attn = "on";
              # 加载到GPU的模型层数
              n-gpu-layers = 99;
              # 卸载到每个 GPU 的模型比例 (逗号分隔)
              # tensor-split = "n,m";
              # 提示词上下文大小
              ctx-size = 131072;
              # 逻辑最大批次大小
              batch-size = 2048;
              # 物理最大批次大小
              ubatch-size = 512;
              # 温度参数
              temp = 0.8;
              # 从概率最⾼的前多少个候选 token ⾥选
              top-k = 40;
              # 从前多少概率的 token 里选
              top-p = 9.5;
              # 存在惩罚
              presence-penalty = 0.0;
              # 是否对聊天使用 Jinja 模板引擎
              jinja = true;
              # 输出详细日志
              verbose = false;
            }
            extraSettings
          ];
          # 是否开放防火墙端口
          openFirewall = true;
        };
      }
      (lib.optionalAttrs (!isWsl) {
        systemd.services.llama-cpp = {
          environment.LD_LIBRARY_PATH = "${config.hardware.nvidia.package.out}/lib";
        };
      })
      (lib.optionalAttrs isWsl {
        systemd.services.llama-cpp = {
          serviceConfig.DeviceAllow = [ "/dev/dxg rwm" ];
          environment.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
        };
      })
    ]
  );
}
