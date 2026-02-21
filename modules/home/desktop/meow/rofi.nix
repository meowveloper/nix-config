{ pkgs, config, userSettings, ... }: let
    rofi-apps = pkgs.writeShellApplication {
        name = "rofi-apps-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/apps.sh;
    };
    rofi-wallpaper = pkgs.writeShellApplication {
        name = "rofi-wallpaper-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/wallpaper.sh;
    };
in {
    home.packages = with pkgs; [
        rofi
        rofi-apps
        rofi-wallpaper
    ];

    xdg.configFile."rofi/apps.sh".source = "${rofi-apps}/bin/rofi-apps-sh";
    xdg.configFile."rofi/apps.sh".executable = true;

    xdg.configFile."rofi/wallpaper.sh".source = "${rofi-wallpaper}/bin/rofi-wallpaper-sh";
    xdg.configFile."rofi/wallpaper.sh".executable = true;

    xdg.configFile."rofi/wallpaper.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/wallpaper.rasi";

    xdg.configFile."rofi/shared".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/shared" ;
    xdg.configFile."rofi/apps.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/apps.rasi";
}
