{ pkgs, config, userSettings, ... }: {
    home.packages = with pkgs; [
        wezterm
    ];

    # Symlink the main config
    xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/wezterm/wezterm.lua";
}