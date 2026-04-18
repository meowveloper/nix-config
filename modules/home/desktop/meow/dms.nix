{ config, userSettings, ... }: {
    xdg.configFile."DankMaterialShell/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/DankMaterialShell/settings.json";
}
