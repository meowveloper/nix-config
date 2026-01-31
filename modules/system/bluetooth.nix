{ ... }: {
  # 1. This allows NixOS to use the proprietary drivers your chip needs
  hardware.enableRedistributableFirmware = true;

  # 2. Enable Bluetooth service
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # Optional: turns it on automatically

}
