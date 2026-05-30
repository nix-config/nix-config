inputs:
{
  device,
  mountpoint,
  ...
}:
{
  type = "disk";
  inherit device;
  content = {
    type = "gpt";
    partitions = {
      data = {
        size = "100%";
        content = {
          type = "filesystem";
          format = "xfs";
          inherit mountpoint;
          mountOptions = [
            "inode64"
            "noatime"
            "largeio"
            "logbufs=8"
            "allocsize=1m"
          ];
        };
      };
    };
  };
}
