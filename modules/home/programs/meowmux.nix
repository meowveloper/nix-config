{ pkgs, inputs, ... }:
{
    home.packages = [
        inputs.meowkey.packages.${pkgs.system}.default
        inputs.meowmux.packages.${pkgs.system}.default
    ];
    xdg.configFile."meowkey".source = ../../../dot-files/programs/.config/meowkey;
}
