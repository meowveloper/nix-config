{ pkgs, config, userSettings, ... }: let
    rofi-lancher = pkgs.writeShellApplication {
        name = "rofi-lancher-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/launcher.sh;
    };
    rofi-wallpaper = pkgs.writeShellApplication {
        name = "rofi-wallpaper-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/wallpaper-launcher.sh;
    };
in {
    home.packages = with pkgs; [
        rofi
        rofi-lancher
        rofi-wallpaper
    ];

    xdg.configFile."rofi/launcher.sh".source = "${rofi-lancher}/bin/rofi-lancher-sh";
    xdg.configFile."rofi/launcher.sh".executable = true;

    xdg.configFile."rofi/wallpaper-launcher.sh".source = "${rofi-wallpaper}/bin/rofi-wallpaper-sh";
    xdg.configFile."rofi/wallpaper-launcher.sh".executable = true;

    xdg.configFile."rofi/wallpaper.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/wallpaper.rasi";

    xdg.configFile."rofi/shared".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/shared" ;
    xdg.configFile."rofi/style-15.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/style-15.rasi";
    xdg.configFile."rofi/style-9.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/style-9.rasi";
}
