{ userSettings, ... }:

let
    shared_path = userSettings.shared_path or "/mnt/extra-volume/shared";
    u1 = userSettings.username1;
    u2 = userSettings.username2;
in {
    users.groups.shared = {
        members = [ u1 u2 ];
    };

    systemd.tmpfiles.rules = [
        "d ${shared_path} 2770 root shared - -"
        "a ${shared_path} - - - - u:${u1}:rwx d:u:${u1}:rwx u:${u2}:rwx d:u:${u2}:rwx m::rwx d:m::rwx"
    ];
}
