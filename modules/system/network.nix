{ machineSettings, ... }: {
    networking.hostName = machineSettings.hostName;
    networking.networkmanager.enable = true;
    services.cloudflare-warp.enable = true;
}
