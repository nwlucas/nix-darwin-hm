{ config, lib, pkgs, ... }:
{
  fileSystems."/" =
    {
      device = "/dev/disk/by-label/NIXOSROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/NIXOSBOOT";
      fsType = "vfat";
    };

  swapDevices =
    [
      {
        device = "/dev/disk/by-label/swap";
      }
    ];
}
