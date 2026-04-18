{ pkgs, config, userSettings, ... }: let
    meow-mango-startup-script = pkgs.writeShellApplication {
        name = "meow-mango-startup-script-sh";
        text = builtins.readFile ../../../../dot-files/meow/.config/mango/start-up.sh;
    };
    meow-toggle-nightlight = pkgs.writeShellApplication {
      name = "meow-toggle-nightlight-sh";
      text = builtins.readFile ../../../../dot-files/meow/.config/mango/toggle-nightlight.sh;
    };
in {
    home.packages = with pkgs; [
        meow-mango-startup-script
        meow-toggle-nightlight
        ghostty
        kdePackages.polkit-kde-agent-1
        grim
        slurp
        libnotify
        brightnessctl
        hyprlock
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

    xdg.configFile."mango/toggle-nightlight.sh".source = "${meow-toggle-nightlight}/bin/meow-toggle-nightlight-sh";
    xdg.configFile."mango/toggle-nightlight.sh".executable = true;
}
