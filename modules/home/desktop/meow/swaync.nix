{pkgs, ...}: {
    services.swaync.enable = false;
    home.packages = with pkgs; [
        swaynotificationcenter
    ];
    xdg.configFile."swaync/css".source = ../../../../dot-files/meow/.config/swaync/css;
    xdg.configFile."swaync/config.json".source = ../../../../dot-files/meow/.config/swaync/config.json;
    xdg.configFile."swaync/style.css".source = ../../../../dot-files/meow/.config/swaync/style.css;
}
