{ pkgs, inputs, ... }:
{
    home.packages = [
        inputs.meowkey.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.meowmux.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
