{
  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "sr_mod" ];

  hardware = {
    bluetooth.enable = false;

    # For MX Master 3 and others
    logitech.wireless = {
      enable = false;
      enableGraphical = false;
    };

    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };
}
