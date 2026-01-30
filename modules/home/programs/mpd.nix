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
    # Optional: startup services
    network.listenAddress = "127.0.0.1";
  };

  home.packages = [ pkgs.rmpc ];

  # RMPC Configuration
  xdg.configFile."rmpc/config.ron".source = ../../../dot-files/.config/rmpc/executable_config.ron;
  xdg.configFile."rmpc/theme.ron".source = ../../../dot-files/.config/rmpc/executable_theme.ron;

  home.activation = {
    createRmpcCache = config.lib.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p $HOME/.rmpc-cache
    '';
  };
}
