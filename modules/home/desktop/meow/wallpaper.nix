{ pkgs, ... }: let
    wallpaper-script = pkgs.writeShellApplication {
        name = "wallpaper-sh"; # The name of the resulting executable
        text = builtins.readFile ../../../../dot-files/meow/.config/waypaper/wallpaper.sh;
    };
in {
    home.packages = with pkgs; [
        matugen
        waypaper
        swww
        wallpaper-script
    ];

    xdg.configFile."matugen".source = ../../../../dot-files/meow/.config/matugen;
    xdg.configFile."waypaper/config.ini".source = ../../../../dot-files/meow/.config/waypaper/config.ini;
    xdg.configFile."waypaper/wallpaper.sh".source = "${wallpaper-script}/bin/wallpaper-sh";
    xdg.configFile."waypaper/wallpaper.sh".executable = true;
}
