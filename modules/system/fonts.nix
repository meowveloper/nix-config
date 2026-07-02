{ pkgs, ... }: {
    fonts.packages = with pkgs; [
        material-symbols
        noto-fonts-color-emoji
        nerd-fonts.symbols-only
        font-awesome
        fira-code
        inter-nerdfont
        noto-fonts
    ];

    fonts.fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Fira Code" "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
    };
}
