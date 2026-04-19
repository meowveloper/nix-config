{ config, userSettings, ... } : {
    xdg.configFile."noctalia/user-templates.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/user-templates.toml";
    xdg.configFile."noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/settings.json";
    xdg.configFile."matugen".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/matugen";
}
