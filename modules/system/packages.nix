{ inputs, pkgs, ... }: {
    programs.gnupg.agent = {
        enable = true;
        enableExtraSocket = true;
        pinentryPackage = pkgs.pinentry-tty; # Or pkgs.pinentry-curses
    };

    programs.fuse.userAllowOther = true;

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
        nodejs_latest
        python3
        eza
        docker

        #others
        nautilus
        btop
        git-lfs
        chromium
        ffmpeg
        cacert

        # video player
        haruna

        #
        obsidian
        acl
        discord
    ];
}
