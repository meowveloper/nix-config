{ pkgs, config, userSettings, ... }: let
    meow-mango-startup-script = pkgs.writeShellApplication {
        name = "meow-mango-startup-script-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/mango/start-up.sh;
    };
in {
    home.packages = with pkgs; [
        meow-mango-startup-script
        grim
        slurp
    ];

    # Symlink the main config
    xdg.configFile."mango/config.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/config.conf";
    xdg.configFile."mango/layout.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/layout.conf";
    xdg.configFile."mango/visuals.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/visuals.conf";
    xdg.configFile."mango/bindings.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/bindings.conf";


    # Symlink the wrapped startup script
    xdg.configFile."mango/start-up.sh".source = "${meow-mango-startup-script}/bin/meow-mango-startup-script-sh";
    xdg.configFile."mango/start-up.sh".executable = true;
}
