{ lib, ... }:

{
  boot = {
    loader = {
      timeout = 1;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}
