{ pkgs, ... }: {
    programs.dank-material-shell = {
        enable = true;
        systemd = {
            enable = true;             # Systemd service for auto-start
            restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
        };
        enableSystemMonitoring = true;     # System monitoring widgets (dgop)
        enableVPN = true;                  # VPN management widget
        enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
        enableAudioWavelength = true;      # Audio visualizer (cava)
        enableCalendarEvents = true;       # Calendar integration (khal)
        enableClipboardPaste = true; 
    };
}
