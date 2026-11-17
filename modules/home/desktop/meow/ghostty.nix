{ pkgs, config, userSettings, ... }: {
    home.packages = with pkgs; [
        ghostty
        brightnessctl
    ];

    # Terminal config stays in the dotfiles repo (mkOutOfStoreSymlink).
    xdg.configFile."ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/ghostty/config";
    xdg.configFile."ghostty/shaders".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/ghostty/shaders";
}
