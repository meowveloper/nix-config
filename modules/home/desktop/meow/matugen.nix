{ pkgs, ... }: {
    home.packages = with pkgs; [
        matugen
        waypaper
        swww
    ];

    xdg.configFile."matugen".source = ../../../../dot-files/meow/.config/matugen;
    xdg.configFile."waypaper".source = ../../../../dot-files/meow/.config/waypaper;
}
