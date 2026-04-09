{ config, userSettings, ... }: {
  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/niri/config.kdl";
}
