{ userSettings, ... }:

{
    users.users.${userSettings.username1} = {
        isNormalUser = true;
        description = "${userSettings.username1}";
        extraGroups = [ "networkmanager" "wheel" "input" ];
    };

    users.users.${userSettings.username2} = {
        isNormalUser = true;
        description = "${userSettings.username2}";
        extraGroups = [ "networkmanager" "wheel" "input" ];
    };
}
