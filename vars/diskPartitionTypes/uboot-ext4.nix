inputs:
{
  device,
  ubootSize ? "8M",
  bootSize ? "1G",
  ...
}:
{
  type = "disk";
  inherit device;
  content = {
    type = "table";
    format = "msdos";
    partitions = [
      {
        name = "BOOT";
        start = ubootSize;
        end = bootSize;
        bootable = true;
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      }
      {
        name = "root";
        start = bootSize;
        end = "100%";
        part-type = "primary";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
          mountOptions = [
            "noatime"
          ];
        };
      }
    ];
  };
}
