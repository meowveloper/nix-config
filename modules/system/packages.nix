{ pkgs, ... }: {
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
        rustup
        bun

        #others
        btop
        git-lfs
        chromium
        ffmpeg
        cacert

        # video player
        yt-dlp
        obs-studio
        kdePackages.kdenlive

        # utilities
        acl
        discord
        zoom-us
        proton-vpn
        openssl
        git-remote-gcrypt
        libreoffice

        # side hobby
        blender
    ];
}
