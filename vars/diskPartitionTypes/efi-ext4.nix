inputs:
{
  device,
  espSize ? "1G",
  ...
}:
{
  type = "disk";
  inherit device;
  content = {
    type = "gpt";
    partitions = {
      ESP = {
        type = "EF00";
        size = espSize;
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };
      root = {
        size = "100%";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
          mountOptions = [
            "noatime"
          ];
        };
      };
    };
  };
}
