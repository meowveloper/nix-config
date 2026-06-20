{ pkgs, config, userSettings, ... }: {
    programs.fastfetch.enable = true;
    programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
    };
    home.packages = with pkgs;[
        opencode
        opencode-desktop
        zed-editor-fhs
    ];

    xdg.configFile."yazi/yazi.toml".source = ../../../dot-files/programs/.config/yazi/executable_yazi.toml;
    xdg.configFile."yazi/keymap.toml".source = ../../../dot-files/programs/.config/yazi/keymap.toml;
    xdg.configFile."yazi/launch.sh".source = ../../../dot-files/programs/.config/yazi/executable_launch.sh;
    xdg.configFile."fastfetch".source = ../../../dot-files/programs/.config/fastfetch;

    xdg.dataFile."applications/opencode-desktop.desktop".source = "${pkgs.opencode-desktop}/share/applications/opencode-desktop.desktop";

    xdg.configFile."opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/agents";
    xdg.configFile."opencode/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/AGENTS.md";
    home.file.".pi/agent/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.pi/agent/settings.json";
    home.file.".pi/agent/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.pi/agent/agents";
    home.file.".gemini/skills".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.gemini/skills";
}
