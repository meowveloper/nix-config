{ pkgs, ... }: {
    home.packages = with pkgs; [
        waybar
    ];
    xdg.configFile."waybar/config.jsonc".source = ../../../../dot-files/meow/.config/waybar/config.jsonc;
    xdg.configFile."waybar/modules.jsonc".source = ../../../../dot-files/meow/.config/waybar/modules.jsonc;
    xdg.configFile."waybar/style.css".source = ../../../../dot-files/meow/.config/waybar/style.css;

}
