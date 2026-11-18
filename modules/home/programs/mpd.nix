{ pkgs, config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      # Audio output – this works perfectly on PipeWire/WirePlumber out of the box
      audio_output {
          type        "pipewire"
          name        "PipeWire Output"
      }

      follow_inside_symlinks "yes"
      auto_update "yes"
    '';
    # Per-user unix socket instead of a shared TCP port, so two users can
    # never fight over 127.0.0.1:6600. Each user gets their own socket file.
    network.listenAddress = "${config.home.homeDirectory}/.local/share/mpd/socket";
  };

  home.packages = [ pkgs.rmpc ];

  # RMPC Configuration
  xdg.configFile."rmpc/config.ron".source = ../../../dot-files/programs/.config/rmpc/executable_config.ron;
  xdg.configFile."rmpc/theme.ron".source = ../../../dot-files/programs/.config/rmpc/executable_theme.ron;

  home.activation = {
    createRmpcCache = config.lib.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p $HOME/.rmpc-cache
    '';
  };
}
