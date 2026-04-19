{ config, userSettings, ... } : {
    xdg.configFile."noctalia/user-templates.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/user-templates.toml";
    xdg.configFile."noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/settings.json";
    xdg.configFile."noctalia/plugins".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/plugins";
    xdg.configFile."noctalia/plugins.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/plugins.json";
    xdg.configFile."matugen".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/matugen";
}
