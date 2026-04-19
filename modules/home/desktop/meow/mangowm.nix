{ pkgs, config, userSettings, ... }: let
    meow-mango-startup-script = pkgs.writeShellApplication {
        name = "meow-mango-startup-script-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/mango/start-up.sh;
    };
    meow-mango-screen-shot-script = pkgs.writeShellApplication {
        name = "meow-mango-screen-shot-script-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/mango/screen-shot.sh;
    };
in {
    home.packages = with pkgs; [
        meow-mango-startup-script
        meow-mango-screen-shot-script
        ghostty
        kdePackages.polkit-kde-agent-1
        grim
        slurp
        libnotify
        brightnessctl
        wlsunset
    ];

    # Symlink the main config
    xdg.configFile."mango/config.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/config.conf";
    xdg.configFile."mango/layout.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/layout.conf";
    xdg.configFile."mango/visuals.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/visuals.conf";
    xdg.configFile."mango/bindings.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/mango/bindings.conf";

    # Terminal Config
    xdg.configFile."ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/ghostty/config";
    xdg.configFile."ghostty/shaders".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/ghostty/shaders";

    # Scripts
    xdg.configFile."mango/start-up.sh".source = "${meow-mango-startup-script}/bin/meow-mango-startup-script-sh";
    xdg.configFile."mango/start-up.sh".executable = true;

    xdg.configFile."mango/screen-shot.sh".source = "${meow-mango-screen-shot-script}/bin/meow-mango-screen-shot-script-sh";
    xdg.configFile."mango/screen-shot.sh".executable = true;

}
