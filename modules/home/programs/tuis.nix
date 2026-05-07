{ pkgs, config, userSettings, ... }: {
    programs.fastfetch.enable = true;
    programs.gemini-cli.enable = true;
    home.packages = with pkgs; [pi-coding-agent];
    programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
    };

    xdg.configFile."yazi/yazi.toml".source = ../../../dot-files/programs/.config/yazi/executable_yazi.toml;
    xdg.configFile."yazi/keymap.toml".source = ../../../dot-files/programs/.config/yazi/keymap.toml;
    xdg.configFile."yazi/launch.sh".source = ../../../dot-files/programs/.config/yazi/executable_launch.sh;
    xdg.configFile."fastfetch".source = ../../../dot-files/programs/.config/fastfetch;

    home.file.".pi/agent/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.pi/agent/settings.json";
    home.file.".pi/agent/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.pi/agent/agents";
}
