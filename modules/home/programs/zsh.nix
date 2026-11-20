{ config, userSettings, ... }: {
    # Manual mode: dot-files/programs/.zshrc owns ~/.zshrc.
    # Do not re-enable programs.zsh unless you remove home.file.".zshrc" above.
    programs.zsh = {
        enable = false;
    };

    # Link your config files so the 'source' commands above work
    xdg.configFile."zsh-config/aliases".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/zsh-config/aliases";
    xdg.configFile."zsh-config/profile".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/zsh-config/profile";
    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.zshrc";
}
