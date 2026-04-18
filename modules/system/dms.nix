{ pkgs, ... }: {
    programs.dconf.enable = true;
    programs.dsearch = {
        enable = true;
        systemd = {
            enable = true;               # Enable systemd user service
            target = "default.target";   # Start with user session
        };
    };

    programs.dms-shell = {
        enable = true;

        systemd = {
            enable = true;
            target = "default.target";
            restartIfChanged = true;
        };

        enableSystemMonitoring = true;
        enableVPN = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;
    };
}
