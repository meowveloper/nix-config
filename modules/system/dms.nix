{ pkgs, ... }: {
    fonts.packages = with pkgs; [
        material-symbols
        noto-fonts-color-emoji
        nerd-fonts.symbols-only 
        font-awesome
        fira-code
        inter-nerdfont
    ];
    programs.dank-material-shell = {
        enable = true;
        enableSystemMonitoring = true;     # System monitoring widgets (dgop)
        enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
        enableAudioWavelength = true;      # Audio visualizer (cava)
        enableCalendarEvents = true;       # Calendar integration (khal)
        enableClipboardPaste = true; 
    };
}
