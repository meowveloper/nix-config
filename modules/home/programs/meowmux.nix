{ pkgs, inputs, ... }:

let
  meowmux = pkgs.stdenv.mkDerivation {
    name = "meowmux";
    src = inputs.meowmux;

    nativeBuildInputs = [ pkgs.zig ];

    # Zig needs a cache directory
    preBuild = ''
      export ZIG_GLOBAL_CACHE_DIR=$TMPDIR/zig-cache
      export ZIG_LOCAL_CACHE_DIR=$TMPDIR/zig-local-cache
    '';

    buildPhase = ''
      zig build -Doptimize=ReleaseSafe --prefix $out
    '';

    # 'zig build --prefix $out' handles installation to $out/bin automatically
    dontInstall = true;
  };
in
{
  home.packages = [ meowmux ];
}
