
{ ... }: {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.libinput.enable = true;

    services.logind.settings.Login.HandleLidSwitch = "lock";
    services.logind.settings.Login.HandleLidSwitchExternalPower = "lock";
    services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
}
