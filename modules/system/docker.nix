{ pkgs, ... }: {
    virtualisation.docker = {
        enable = true;
        # optional — only uncomment if container downloads fail
        # daemon.settings.dns = [ "1.1.1.1" "9.9.9.9" ];
    };

    environment.systemPackages = [ pkgs.docker-compose ];
}
