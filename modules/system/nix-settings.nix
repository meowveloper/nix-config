{ pkgs, machineSettings, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # this is to prevent from overheating during builds
    nix.settings = {
        # Limit the number of concurrent builds
        max-jobs = machineSettings.maxJobs;
        # Limit the number of cores each build can use
        cores = machineSettings.cores;
        # Give the build process lower priority so your UI doesn't lag
        auto-optimise-store = true;
    };

    # Enable nix-ld to run unpatched binaries (like those installed by Mason)
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        fuse3
        icu
        nss
        openssl
        curl
        expat

        # Chromium/Chrome browser dependencies (for agent-browser, etc.)
        atk
        at-spi2-atk
        at-spi2-core
        alsa-lib
        cairo
        cups
        dbus
        glib
        libxkbcommon
        libgbm
        mesa
        nspr
        pango
        systemd
        libx11
        libxcomposite
        libxdamage
        libxext
        libxfixes
        libxrandr
        libxcb
    ];

    zramSwap = {
        enable = true;
        priority = 100;
        algorithm = "zstd";
        memoryPercent = 200;
    };

}
