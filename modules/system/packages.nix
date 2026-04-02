{ pkgs, ... }: {
    programs.gnupg.agent = {
        enable = true;
        enableExtraSocket = true;
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
        git-remote-gcrypt
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

        # video player
        haruna

        #
        cryptomator
        obsidian
        acl
    ];
}
