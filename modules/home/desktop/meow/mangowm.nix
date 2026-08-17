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

    # Activate the user graphical session target so xdg-desktop-portal can start.
    # xdg-desktop-portal.service requires graphical-session.target (Requisite=);
    # MangoWM is launched as a plain greetd command and never activates it,
    # causing the portal to fail with a dependency error and breaking screen
    # sharing.
    # NOTE: systemd's stock graphical-session.target has RefuseManualStart=yes,
    # so a manual `systemctl --user start graphical-session.target` is refused
    # (exit 4, "may be requested by dependency only"). Pulling it in via Wants
    # (dependency activation) is allowed and is what makes the target active.
    systemd.user.services.mango-graphical-session = {
      Unit = {
        Description = "Activate graphical-session.target for MangoWM";
        After = [ "graphical-session-pre.target" ];
        Wants = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.coreutils}/bin/true";
      };
      Install.WantedBy = [ "default.target" ];
    };
}
