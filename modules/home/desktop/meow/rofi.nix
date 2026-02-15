{ pkgs, ... }: let
    rofi-lancher = pkgs.writeShellApplication {
        name = "rofi-lancher-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/launcher.sh;
    };
in {
    home.packages = with pkgs; [
        rofi
        rofi-lancher
    ];

    xdg.configFile."rofi/launcher.sh".source = "${rofi-lancher}/bin/rofi-lancher-sh";
    xdg.configFile."rofi/launcher.sh".executable = true;

    xdg.configFile."rofi/shared".source = ../../../../dot-files/meow/.config/rofi/shared;
    xdg.configFile."rofi/style-15.rasi".source = ../../../../dot-files/meow/.config/rofi/style-15.rasi;
    xdg.configFile."rofi/style-9.rasi".source = ../../../../dot-files/meow/.config/rofi/style-9.rasi;
}
