{ pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # this is to prevent from overheating during builds
    nix.settings = {
        # Limit the number of concurrent builds
        max-jobs = 4;
        # Limit the number of cores each build can use
        cores = 4;
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
    ];

    zramSwap = {
        enable = true;
        priority = 100;
        algorithm = "zstd";
        memoryPercent = 200;
    };

}
