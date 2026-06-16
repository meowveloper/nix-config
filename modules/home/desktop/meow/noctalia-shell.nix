{ config, userSettings, ... } : {
    xdg.configFile."noctalia/user-templates.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/user-templates.toml";
    xdg.configFile."matugen".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/matugen";
    xdg.configFile."noctalia/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/noctalia/config.toml";
}
