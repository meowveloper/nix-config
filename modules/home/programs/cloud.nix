{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    cryptomator
    rclone
  ];

  # Rclone systemd user service to mount Google Drive
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Rclone Mount for Google Drive";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = {
      Type = "notify";
      # Ensure the mount directory exists
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${config.home.homeDirectory}/Cloud/GoogleDrive";
      
      # The mount command
      # --vfs-cache-mode full is required for Cryptomator to work correctly
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount google-drive: ${config.home.homeDirectory}/Cloud/GoogleDrive \
          --vfs-cache-mode full \
          --vfs-cache-max-size 10G \
          --vfs-cache-max-age 24h \
          --vfs-read-chunk-size 32M \
          --vfs-read-chunk-size-limit 1G \
          --dir-cache-time 72h \
          --buffer-size 32M \
          --no-modtime \
          --vfs-read-wait 0ms \
          --transfers 4 \
          --checkers 8 \
          --log-level INFO \
          --umask 022
      '';
      
      # Unmount on stop
      ExecStop = "/run/wrappers/bin/fusermount3 -u ${config.home.homeDirectory}/Cloud/GoogleDrive";
      
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin:/run/current-system/sw/bin" ];
    };
  };
}
