{ pkgs, ... }: {
    home.packages = with pkgs; [
        matugen
    ];

    xdg.configFile."matugen".source = ../../../../dot-files/meow/.config/matugen;
}
