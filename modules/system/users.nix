{ userSettings, ... }:

{
  users.users.${userSettings.username1} = {
    isNormalUser = true;
    description = "Primary User";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };

  users.users.${userSettings.username2} = {
    isNormalUser = true;
    description = "Secondary User";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };
}
