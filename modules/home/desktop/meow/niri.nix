{ config, pkgs, userSettings, ... }:
let
    meow-niri-startup-script = pkgs.writeShellApplication {
        name = "meow-niri-startup-script-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/niri/start-up.sh;
    };
in
{
    xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/niri/config.kdl";

    xdg.configFile."niri/start-up.sh".source = "${meow-niri-startup-script}/bin/meow-niri-startup-script-sh";
    xdg.configFile."niri/start-up.sh".executable = true;
}
