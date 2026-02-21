{ pkgs, ... }: let
    matugen-wallpaper-script = pkgs.writeShellApplication {
        name = "matugen-wallpaper-sh"; # The name of the resulting executable
        text = builtins.readFile ../../../../dot-files/meow/.config/matugen/wallpaper.sh;
    };
in {
    home.packages = with pkgs; [
        matugen
        swww
        matugen-wallpaper-script
    ];

    xdg.configFile."matugen/templates".source = ../../../../dot-files/meow/.config/matugen/templates;
    xdg.configFile."matugen/config.toml".source = ../../../../dot-files/meow/.config/matugen/config.toml;
    xdg.configFile."matugen/wallpaper.sh".source = "${matugen-wallpaper-script}/bin/matugen-wallpaper-sh";
    xdg.configFile."matugen/wallpaper.sh".executable = true;
}
