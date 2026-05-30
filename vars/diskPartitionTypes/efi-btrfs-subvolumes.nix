inputs:
{
  device,
  espSize ? "1G",
  swapSize ? "4G",
  enableSnapshots ? true,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
in
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
          type = "btrfs";
          subvolumes = {
            "@" = {
              mountpoint = "/";
              mountOptions = [
                "noatime"
                "compress=zstd"
              ];
            };
            "@home" = {
              mountpoint = "/home";
              mountOptions = [ "compress=zstd" ];
            };
            "@nix" = {
              mountpoint = "/nix";
              mountOptions = [
                "noatime"
                "compress=zstd"
              ];
            };
            "@log" = {
              mountpoint = "/var/log";
              mountOptions = [
                "noatime"
                "compress=zstd"
              ];
            };
          }
          # 仅在 swap 不为 null 时追加 @swap
          // lib.optionalAttrs (swapSize != null) {
            "@swap" = {
              mountpoint = "/.swap";
              mountOptions = [ "nodatacow" ];
              swap.swapfile.size = swapSize;
            };
          }
          # 仅在 enableSnapshots 为 true 时追加 @snapshots 和 @home-snapshots
          // lib.optionalAttrs enableSnapshots {
            "@snapshots" = {
              mountpoint = "/.snapshots";
              mountOptions = [ "compress=zstd" ];
            };
            "@home-snapshots" = {
              mountpoint = "/home/.snapshots";
              mountOptions = [ "compress=zstd" ];
            };
          };
        };
      };
    };
  };
}
