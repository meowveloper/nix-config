{ userSettings, ... }:

{
    systemd.tmpfiles.rules = [
        "Z ${builtins.toString userSettings.dotfiles_path} 2775 root dotfiles - -"
    ];
}
