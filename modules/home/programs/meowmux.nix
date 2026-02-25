{ pkgs, inputs, ... }:

let
    meowmux = pkgs.stdenv.mkDerivation {
        name = "meowmux";
        src = inputs.meowmux;

        nativeBuildInputs = [ inputs.zig-overlay.packages.${pkgs.system}."0.15.2" ];

        dontConfigure = true;

        buildPhase = ''
        export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig-cache
        export ZIG_LOCAL_CACHE_DIR=$TMPDIR/zig-local-cache
        mkdir -p $ZIG_GLOBAL_CACHE_DIR $ZIG_LOCAL_CACHE_DIR

        zig build -Doptimize=ReleaseSafe --prefix $out --global-cache-dir $ZIG_GLOBAL_CACHE_DIR
        '';

        # 'zig build --prefix $out' handles installation to $out/bin automatically
        dontInstall = true;
    };
in {
    home.packages = [
        meowmux
        inputs.meowkey.packages.${pkgs.system}.default
    ];
    xdg.configFile."meowkey".source = ../../../dot-files/programs/.config/meowkey;
}
