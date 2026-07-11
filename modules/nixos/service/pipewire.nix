{
  lib,
  opts,
  ...
}:
let
  enableModule = opts.service.pipewire.enable;
in
{
  config = lib.mkIf enableModule {
    services = {
      # 禁用 PulseAudio(使用 PipeWire 替代)
      pulseaudio.enable = false;
      # 启用 PipeWire 多媒体框架
      pipewire = {
        enable = true;
        # 启用 PipeWire 的 ALSA 兼容层
        alsa.enable = true;
        # 支持 32 位 ALSA 应用
        alsa.support32Bit = true;
        # 启用 PulseAudio 兼容层
        pulse.enable = true;
      };
    };
  };
}
