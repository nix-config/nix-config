{
  inputs,
  ...
}:
{
  imports = [ inputs.nixos-wsl.nixosModules.default ];
  wsl = {
    enable = true;
    defaultUser = "admin";
    useWindowsDriver = true;
    # 启用任何 binfmt 注册时必须重新注册 WSLInterop, 否则 .exe 互操作失效
    interop.register = true;
  };
  # 通过 qemu-user 模拟构建 aarch64-linux
  boot.binfmt = {
    emulatedSystems = [ "aarch64-linux" ];
    preferStaticEmulators = true;
  };
}
