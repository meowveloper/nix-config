{ userSettings, pkgs, ... }:

let
    shared_path = userSettings.shared_path or "/mnt/extra-volume/shared";
    u1 = userSettings.username1;
    u2 = userSettings.username2;
in {
    users.groups.shared = {
        members = [ u1 u2 ];
    };

    systemd.tmpfiles.rules = [
        # create the folder: setgid (2), rwx for owner+group, no others
        "d ${shared_path} 2770 root shared - -"
        # per-user ACL + default ACL, COMMA-SEPARATED (required by systemd-tmpfiles)
        "a ${shared_path} - - - - u:${u1}:rwx,d:u:${u1}:rwx,u:${u2}:rwx,d:u:${u2}:rwx,m::rwx,d:m::rwx"
    ];

    # Recursively apply full-access ACLs to everything in the shared folder:
    # fixes existing content (e.g. the Cryptomator vault) and re-applies on a
    # schedule so files moved in later (which keep their old perms) get fixed.
    systemd.services.shared-acl = {
        description = "Apply shared-folder ACLs recursively";
        after = [ "systemd-tmpfiles-setup.service" ];
        wantedBy = [ "multi-user.target" ];
        unitConfig.RequiresMountsFor = shared_path;
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
        };
        path = [ pkgs.acl ];
        script = ''
            setfacl -R -m u:${u1}:rwx,u:${u2}:rwx,m::rwx ${shared_path}
            find ${shared_path} -type d -exec setfacl -d -m u:${u1}:rwx,u:${u2}:rwx,m::rwx {} +
        '';
    };

    systemd.timers.shared-acl = {
        description = "Periodically refresh shared-folder ACLs";
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnBootSec = "5m";
            OnUnitActiveSec = "5m";
        };
    };
}
