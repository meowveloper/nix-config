
{ ... }: {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.libinput.enable = true;

    services.logind.lidSwitch = "lock";
    services.logind.lidSwitchExternalPower = "lock";
    services.logind.lidSwitchDocked = "ignore";
}
