{ pkgs, ... }: {
    home.packages = with pkgs; [
        matugen
        waypaper
        swww
    ];

    xdg.configFile."matugen".source = ../../../../dot-files/meow/.config/matugen;
    xdg.configFile."waypaper/config.ini".source = ../../../../dot-files/meow/.config/waypaper/config.ini;


    xdg.configFile."waypaper/wallpaper.sh".text = ''
        #!/usr/bin/env bash
        WALL="$1"

        rm ~/.cache/last-wallpaper
        cp $WALL ~/.cache/last-wallpaper

        matugen image "$WALL"
    '';
    xdg.configFile."waypaper/wallpaper.sh".executable = true;
}
