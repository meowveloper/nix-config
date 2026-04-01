{ pkgs, config, userSettings, ... }: let
    rofi-apps = pkgs.writeShellApplication {
        name = "rofi-apps-sh";
        runtimeInputs = with pkgs; [ rofi ];
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/apps.sh;
    };
    rofi-wallpaper = pkgs.writeShellApplication {
        name = "rofi-wallpaper-sh";
        runtimeInputs = with pkgs; [ rofi libnotify findutils coreutils ];
        text = builtins.readFile ../../../../dot-files/meow/.config/rofi/wallpaper.sh;
    };
    rofi-clipboard = pkgs.writeShellApplication {
        name = "rofi-clipboard-sh";
        runtimeInputs = with pkgs; [ rofi cliphist wl-clipboard ];
        text = ''
            dir="$HOME/.config/rofi"
            theme='clipboard'

            while true; do
                choice=$( (echo "󰃢  Clear All History"; cliphist list) | \
                    rofi -dmenu -theme "''${dir}"/"''${theme}".rasi -p "Clipboard" -mesg "Select item to manage")

                if [ -z "$choice" ]; then
                    exit 0
                fi

                if [ "$choice" = "󰃢  Clear All History" ]; then
                    res=$(echo -e "No\nYes" | rofi -dmenu -p "Wipe all history?" -theme "''${dir}"/"''${theme}".rasi)
                    if [ "$res" = "Yes" ]; then
                        cliphist wipe
                    fi
                else
                    # Action Sub-menu
                    action=$(echo -e "󰆏 Copy\n󰆴 Delete\n󰅖 Cancel" | \
                        rofi -dmenu -p "Action" -theme "''${dir}"/"''${theme}".rasi -mesg "Item: ''${choice:0:60}...")
                    
                    case "$action" in
                        "󰆏 Copy")
                            echo "$choice" | cliphist decode | wl-copy
                            exit 0
                            ;;
                        "󰆴 Delete")
                            echo "$choice" | cliphist delete
                            # Continue loop to show updated list
                            ;;
                        *)
                            # Back to list
                            ;;
                    esac
                fi
            done
        '';
    };
in {
    home.packages = with pkgs; [
        rofi
        rofi-apps
        rofi-wallpaper
        rofi-clipboard
        cliphist
        wl-clipboard
    ];

    xdg.configFile."rofi/apps.sh".source = "${rofi-apps}/bin/rofi-apps-sh";
    xdg.configFile."rofi/apps.sh".executable = true;

    xdg.configFile."rofi/wallpaper.sh".source = "${rofi-wallpaper}/bin/rofi-wallpaper-sh";
    xdg.configFile."rofi/wallpaper.sh".executable = true;

    xdg.configFile."rofi/clipboard.sh".source = "${rofi-clipboard}/bin/rofi-clipboard-sh";
    xdg.configFile."rofi/clipboard.sh".executable = true;

    xdg.configFile."rofi/wallpaper.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/wallpaper.rasi";
    xdg.configFile."rofi/clipboard.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/clipboard.rasi";

    xdg.configFile."rofi/shared".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/shared" ;
    xdg.configFile."rofi/apps.rasi".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/rofi/apps.rasi";
}
