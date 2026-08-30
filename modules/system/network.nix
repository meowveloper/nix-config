{ machineSettings, ... }: {
  networking.hostName = machineSettings.hostName;
  networking.networkmanager.enable = true;
}
