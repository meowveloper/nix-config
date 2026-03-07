{ pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
