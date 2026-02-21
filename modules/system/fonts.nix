{ pkgs, ... }: {
    fonts.packages = with pkgs; [
        material-symbols
        noto-fonts-color-emoji
        nerd-fonts.symbols-only 
        font-awesome
        fira-code
        inter-nerdfont
    ];
}
