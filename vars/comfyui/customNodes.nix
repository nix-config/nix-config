inputs: pkgs: {
  comfyui-crystools = {
    name = "ComfyUI-Crystools";
    src = pkgs.fetchFromGitHub {
      owner = "crystian";
      repo = "ComfyUI-Crystools";
      rev = "2f18256c5b5063937106f29a8e0a7db3ae3869b7";
      hash = "sha256-IvLgvudqJV6QeNxwA3HbIlGxShCfUBBSZ8DSjOVlSyE=";
    };
    extraPackages =
      ps: with ps; [
        deepdiff
        piexif
        py-cpuinfo
        pynvml
      ];
  };
}
