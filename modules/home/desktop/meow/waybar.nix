{ pkgs, config, userSettings, ... }: {
    services.network-manager-applet.enable = true;
    home.packages = with pkgs; [
        waybar
        networkmanagerapplet
        bluetui
    ];

    xdg.configFile."waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/waybar/config.jsonc";
    xdg.configFile."waybar/modules.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/waybar/modules.jsonc";
    xdg.configFile."waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/waybar/style.css";

    xdg.configFile."waybar/restart.sh".text = ''
        #!/usr/bin/env bash

        pkill -9 waybar

        waybar & disown
    '';
    xdg.configFile."waybar/restart.sh".executable = true;

}
