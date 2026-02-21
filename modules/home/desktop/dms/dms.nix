{ config, userSettings, ... }: {
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableClipboardPaste = true; 
  };
  xdg.configFile."DankMaterialShell/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/dms/.config/DankMaterialShell/settings.json";
}
