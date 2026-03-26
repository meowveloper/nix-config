{ pkgs, ... }: {
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-tty; # Or pkgs.pinentry-curses
    };

    environment.systemPackages = with pkgs; [
        wget
        lazygit
        ripgrep
        fd
        fzf
        zoxide
        git
        bat
        
        # Development Basics
        gcc
        gnumake
        nodejs
        eza

        #others
        nautilus
        btop
        git-lfs
        chromium
        ffmpeg
        gnupg
        git-remote-gcrypt
        pinentry-tty

        # video player
        haruna
    ];
}
